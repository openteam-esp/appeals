class Appeal < ActiveRecord::Base
  belongs_to :topic

  has_one :address

  accepts_nested_attributes_for :address

  has_enum :answer_kind, %w[email post]

  state_machine :state, :initial => :draft do
    state :fresh do
      validates_presence_of :surname, :name, :answer_kind, :topic, :text
      validates_presence_of :email,   :if => Proc.new { |appeal| appeal.answer_kind == 'email' }
      validates_presence_of :address, :if => Proc.new { |appeal| appeal.answer_kind == 'post' }
    end
    state :registred
    state :replied

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
end
