# encoding: utf-8

class Appeal < ActiveRecord::Base
  class_attribute :request_env
  self.request_env = {}

  belongs_to :deleted_by,         :class_name => 'User'
  belongs_to :topic
  belongs_to :section

  has_one  :address,      :dependent => :destroy
  has_one  :note,         :dependent => :destroy
  has_one  :redirect,     :dependent => :destroy
  has_one  :registration, :dependent => :destroy
  has_one  :reply,        :dependent => :destroy
  has_one  :review,       :dependent => :destroy

  validates :email,
            :presence => true,
            :length => { :minimum => 5, :maximum => 255 },
            :format => /^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/i,
            :if => [:answer_kind_email?, :validate_basic_fields?]

  validates_presence_of :answer_kind,
                        :name,
                        :surname,
                        :text,
                        :topic,
                        :if => :validate_basic_fields?

  validates_presence_of :section

  validates_presence_of :address, :if => [:answer_kind_post?, :validate_basic_fields?]

  validates_uniqueness_of :code

  validates_length_of :name, :surname, :patronymic, :phone, :social_status,
                      :maximum => 255,
                      :if => :validate_basic_fields?

  validates_format_of :name, :surname,
                      :with => /\A([ёЁа-яА-Я]+\s*)+\z/,
                      :on => :create,
                      :if => :validate_basic_fields?

  accepts_nested_attributes_for :address

  before_validation :set_address_validation, :if => [:answer_kind_post?, :validate_basic_fields?]

  scope :for, ->(user) { where :section_id => user.context_tree_of(Section).map(&:id) }

  scope :by_state, ->(state) { where(:state => state).not_deleted }
  scope :not_deleted, where(:deleted_at => nil)
  scope :trash, where('deleted_at IS NOT NULL')

  scope :folder, ->(state) do
    case state.to_sym
      when :closed
        by_state(state).joins(:reply).order('replies.replied_on desc')

      when :fresh
        by_state(state).order('appeals.created_at')

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

  after_create :set_root_path, :unless => :root_path?

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
      transition :registered => :fresh, :unless => ->(a) { a.is_a?(KremlinAppeal) }

      transition :noted => :registered,
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

  audited

  def move_to_trash_by(user)
    self.tap do |appeal|
      appeal.update_attributes :deleted_at => Time.now, :deleted_by => user
    end
  end

  def deleted?
    deleted_by_id
  end

  def restore
    self.tap do |appeal|
      appeal.update_attributes :deleted_by => nil,
                               :deleted_at => nil
    end
  end

  def reply_valid?
    self.reply ||= self.build_reply
    self.reply.use_validation = true

    self.reply.valid?
  end

  def author=(full_name)
    self.surname, self.name, self.patronymic = full_name.split(' ')
  end

  def author
    "#{self.surname} #{self.name} #{self.patronymic}".squish
  end

  def attention_level
    return "blank" if closed? || noted? || redirected?
    return "#{state}_#{((Time.now - created_at)/60/60/24).ceil}_days" if fresh?
    return "#{state}_#{(Date.today - registration_registered_on).to_i+1}_days" if registered? || reviewing?
  end

  protected

  def set_code
    while !Appeal.find_by_code(self.code = generate_code).nil?; end
  end

  def generate_code(total_size=12, chunk_size=3, delimiter='-')
    (sprintf "%0#{total_size}d", SecureRandom.random_number(10**total_size)).scan(/\d{#{chunk_size}}/).join(delimiter)
  end

  def set_audit_info
    self.user_proxy_ip = self.class.request_env['HTTP_X_FORWARDED_FOR']
    self.user_ip = self.class.request_env['REMOTE_ADDR']
    self.user_agent = self.class.request_env['HTTP_USER_AGENT']
    self.user_referrer = self.class.request_env['HTTP_REFERER']
  end

  def set_address_validation
    self.address ||= build_address
    self.address.use_validation = true
  end

  def set_root_path
    update_attribute :root_path, PathInterpolator.generate_path(:section_id => section.id, :class_name => self.class.name.downcase)
  end

  def validate_basic_fields?
    true
  end
end


# == Schema Information
#
# Table name: appeals
#
#  id            :integer         not null, primary key
#  deleted_by_id :integer
#  section_id    :integer
#  topic_id      :integer
#  public        :boolean
#  deleted_at    :datetime
#  answer_kind   :string(255)
#  code          :string(255)
#  email         :string(255)
#  name          :string(255)
#  surname       :string(255)
#  patronymic    :string(255)
#  phone         :string(255)
#  root_path     :string(255)
#  social_status :string(255)
#  state         :string(255)
#  user_agent    :text
#  user_ip       :string(255)
#  user_proxy_ip :string(255)
#  user_referrer :text
#  text          :text
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

