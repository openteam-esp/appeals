class Appeal < ActiveRecord::Base
  belongs_to :topic

  has_one :address, :dependent => :destroy
  has_one :registration, :dependent => :destroy

  accepts_nested_attributes_for :address

  default_scope order('created_at')

  scope :folder, ->(state) { where(:state => state) }

  has_enum :answer_kind, %w[email post]

  state_machine :state, :initial => :draft do
    state :fresh do
      validates_presence_of :surname, :name, :answer_kind, :topic, :text, :topic_id, :code
      validates_uniqueness_of :code
      validates_presence_of :email,   :if => Proc.new { |appeal| appeal.answer_kind == 'email' }
      validates_presence_of :address, :if => Proc.new { |appeal| appeal.answer_kind == 'post' }
    end
    state :registred
    state :replied

    after_transition :registred => :fresh do | appeal, transition |
      appeal.registration.destroy
    end

    before_transition :draft => :fresh, :do => :set_code

    event :dispatch do
      transition :draft => :fresh
    end

    event :register do
      transition :fresh => :registred
    end

    event :reply do
      transition :registred => :replied
    end

    event :revert do
      transition :replied => :registred, :registred => :fresh
    end
  end

  private
    def set_code
      while !Appeal.find_by_code(self.code = generate_code).nil?; end
    end

    def generate_code(total_size=12, chunk_size=3, delimiter='-')
      (sprintf "%0#{total_size}d", SecureRandom.random_number(10**total_size)).scan(/\d{#{chunk_size}}/).join(delimiter)
    end
end
