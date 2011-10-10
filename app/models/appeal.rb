class Appeal < ActiveRecord::Base
  cattr_accessor :user_ip, :proxy_ip, :user_agent, :referrer

  belongs_to :topic

  has_one :address, :dependent => :destroy
  has_one :registration, :dependent => :destroy
  has_one :reply, :dependent => :destroy

  validates_presence_of :surname, :name, :answer_kind, :topic, :text

  validates_presence_of :email,   :if => :answer_kind_email?
  validates_presence_of :address, :if => :answer_kind_post?

  validates_uniqueness_of :code

  accepts_nested_attributes_for :address

  scope :folder, ->(state) {
    case state.to_sym
      when :fresh
        where(:state => state).order('created_at')
      when :registred
        where(:state => state).joins(:registration).order('registrations.registred_on')
      when :closed
        where(:state => state).joins(:reply).order('replies.replied_on desc')
    end
  }

  before_create :set_code
  before_create :set_audit_info

  delegate :number, :registred_on, :directed_to,
           :to => :registration,
           :prefix => true, :allow_nil => true

  has_enum :answer_kind, %w[email post]

  paginates_per 15

  state_machine :state, :initial => :fresh do
    state :registred
    state :closed

    after_transition :registred => :fresh do |appeal, transition|
      appeal.registration.destroy
    end

    after_transition :closed => :registred do |appeal, transition|
      appeal.reply.destroy
    end

    event :register do
      transition :fresh => :registred
    end

    event :close do
      transition :registred => :closed, :if => :reply_valid?
    end

    event :revert do
      transition :closed => :registred, :registred => :fresh
    end
  end

  searchable do
    string :state

    text :full_name
    text :registration_number
    text :registration_registred_on do
      I18n.l self.registration_registred_on if self.registration
    end
  end

  def reply_valid?
    self.reply ||= self.build_reply
    self.reply.use_validation = true
    self.reply.valid?
  end

  def full_name
    "#{surname} #{name} #{patronymic}"
  end

  def self.audit(request)
    self.proxy_ip = request.env['HTTP_X_FORWARDED_FOR']
    self.user_ip = request.remote_ip
    self.user_agent = request.env['HTTP_USER_AGENT']
    self.referrer = request.env['HTTP_REFERER']
  end

  private
    def set_code
      while !Appeal.find_by_code(self.code = generate_code).nil?; end
    end

    def generate_code(total_size=12, chunk_size=3, delimiter='-')
      (sprintf "%0#{total_size}d", SecureRandom.random_number(10**total_size)).scan(/\d{#{chunk_size}}/).join(delimiter)
    end

    def set_audit_info
      self.proxy_ip = self.class.proxy_ip
      self.user_ip = self.class.user_ip
      self.user_agent = self.class.user_agent
      self.referrer = self.class.referrer
    end
end

# == Schema Information
#
# Table name: appeals
#
#  id         :integer         not null, primary key
#  surname    :string(255)
#  created_at :datetime
#  updated_at :datetime
#  name       :string(255)
#  patronymic :string(255)
#  topic_id   :integer
#  email      :string(255)
#  address_id :integer
#  phone      :string(255)
#  text       :text
#  public     :boolean
#  state      :string(255)
#  code       :string(255)
#  user_ip    :string(255)
#  proxy_ip   :string(255)
#  user_agent :string(255)
#  referrer   :string(255)
#
