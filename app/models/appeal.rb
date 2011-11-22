class Appeal < ActiveRecord::Base
  class_attribute :request_env
  self.request_env = {}

  belongs_to :deleted_by,         :class_name => 'User'
  belongs_to :destroy_appeal_job, :class_name => 'Delayed::Backend::ActiveRecord::Job'
  belongs_to :topic
  belongs_to :section

  has_one  :address,      :dependent => :destroy
  has_one  :note,         :dependent => :destroy
  has_one  :redirect,     :dependent => :destroy
  has_one  :registration, :dependent => :destroy
  has_one  :reply,        :dependent => :destroy
  has_one  :review,       :dependent => :destroy
  has_many :uploads,      :dependent => :destroy, :as => :uploadable

  validates :email,
            :presence => true,
            :format => /^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/i, :if => :answer_kind_email?

  validates_presence_of :answer_kind,
                        :name,
                        :surname,
                        :text,
                        :topic,
                        :section

  validates_presence_of :address, :if => :answer_kind_post?

  validates_uniqueness_of :code

  accepts_nested_attributes_for :address

  before_validation :set_address_validation, :if => :answer_kind_post?

  scope :by_state, ->(state) { where(:state => state).not_deleted }
  scope :not_deleted, where(:deleted_at => nil)
  scope :trash, where('deleted_at IS NOT NULL')

  scope :folder, ->(state) do
    case state.to_sym
      when :closed
        by_state(state).joins(:reply).order('replies.replied_on desc')

      when :fresh
        by_state(state).order('created_at')

      when :noted
        by_state(state).joins(:note).order('notes.created_at')

      when :redirected
        by_state(state).joins(:redirect).order('redirects.created_at')

      when :registered
        by_state(state).joins(:registration).order('registrations.registered_on')

      when :reviewing
        by_state(state).joins(:review).order('reviews.created_at')

      when :trash
        trash
    end
  end

  before_create :set_code
  before_create :set_audit_info

  delegate :number, :registered_on, :directed_to,
           :to => :registration,
           :prefix => true, :allow_nil => true

  delegate :number, :replied_on, :replied_by,
           :to => :reply,
           :prefix => true, :allow_nil => true

  delegate :full_address, :to => :address, :allow_nil => true

  has_enums

  paginates_per 15

  state_machine :state, :initial => :fresh do
    state :closed
    state :fresh
    state :noted
    state :redirected
    state :registered
    state :reviewing

    after_transition :registered => :fresh do |appeal, transition|
      appeal.registration.destroy
    end

    after_transition :registered => :reviewing do |appeal, transition|
      appeal.create_reply unless appeal.reply
    end

    after_transition :noted => :registered do |appeal, transition|
      appeal.note.destroy
    end

    after_transition :redirected => :registered do |appeal, transition|
      appeal.redirect.destroy
    end

    after_transition :reviewing => :registered do |appeal, transition|
      appeal.review.destroy
    end

    event :to_register do
      transition :fresh => :registered
    end

    event :to_note do
      transition :registered => :noted
    end

    event :to_redirect do
      transition :registered => :redirected
    end

    event :to_review do
      transition :registered => :reviewing
    end

    event :to_close do
      transition :reviewing => :closed, :if => :reply_valid?
    end

    event :to_revert do
      transition :registered => :fresh,
                 :noted => :registered,
                 :redirected => :registered,
                 :reviewing => :registered,
                 :closed => :reviewing
    end
  end

  searchable do
    string :state
    text :author

    text :registration_number
    text :registration_registered_on do
      I18n.l self.registration_registered_on if self.registration
    end

    text :reply_number do
      self.reply_number if self.reply
    end

    text :reply_replied_on do
      I18n.l(self.reply_replied_on) if self.reply.try(:replied_on)
    end

    text :reply_replied_by do
      self.reply_replied_by if self.reply
    end
  end

  alias :destroy_without_trash :destroy

  def destroy
    self.tap do |appeal|
      appeal.update_attributes :deleted_at => Time.now,
                               :deleted_by => User.current,
                               :destroy_appeal_job => Delayed::Job.enqueue(:run_at => 30.days.since, :payload_object => DestroyAppealJob.new(self.id))
    end
  end

  def deleted?
    deleted_by_id
  end

  def restore
    self.tap do |appeal|
      appeal.update_attributes :deleted_by => nil,
                               :deleted_at => nil
      appeal.destroy_appeal_job.destroy
    end
  end

  def reply_valid?
    self.reply ||= self.build_reply
    self.reply.use_validation = true
    self.reply.valid?
  end

  def author
    "#{self.surname} #{self.name} #{self.patronymic}".squish
  end

  def attention_level
    return "blank" if closed? || noted? || redirected?
    return "#{state}_#{((Time.now - created_at)/60/60/24).ceil}_days" if fresh?
    return "#{state}_#{(Date.today - registration_registered_on).to_i+1}_days" if registered? || reviewing?
  end

  private
    def set_code
      while !Appeal.find_by_code(self.code = generate_code).nil?; end
    end

    def generate_code(total_size=12, chunk_size=3, delimiter='-')
      (sprintf "%0#{total_size}d", SecureRandom.random_number(10**total_size)).scan(/\d{#{chunk_size}}/).join(delimiter)
    end

    def set_audit_info
      self.proxy_ip = self.class.request_env['HTTP_X_FORWARDED_FOR']
      self.user_ip = self.class.request_env['REMOTE_ADDR']
      self.user_agent = self.class.request_env['HTTP_USER_AGENT']
      self.referrer = self.class.request_env['HTTP_REFERER']
    end

    def set_address_validation
      self.address ||= build_address
      self.address.use_validation = true
    end
end


# == Schema Information
#
# Table name: appeals
#
#  id                    :integer         not null, primary key
#  surname               :string(255)
#  name                  :string(255)
#  patronymic            :string(255)
#  topic_id              :integer
#  email                 :string(255)
#  phone                 :string(255)
#  text                  :text
#  public                :boolean
#  answer_kind           :string(255)
#  created_at            :datetime
#  updated_at            :datetime
#  state                 :string(255)
#  code                  :string(255)
#  user_ip               :string(255)
#  proxy_ip              :string(255)
#  user_agent            :string(255)
#  referrer              :string(255)
#  deleted_at            :datetime
#  deleted_by_id         :integer
#  destroy_appeal_job_id :integer
#

