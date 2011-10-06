class Appeal < ActiveRecord::Base
  belongs_to :topic

  has_one :address

  accepts_nested_attributes_for :address

  validates_presence_of :surname, :name, :answer_kind, :topic, :text

  validates_presence_of :email,   :if => Proc.new { |appeal| appeal.answer_kind == 'email' }
  validates_presence_of :address, :if => Proc.new { |appeal| appeal.answer_kind == 'post' }

  has_enum :answer_kind, %w[email post]
end
