class CheckStatus
  include ActiveModel::Validations

  attr_accessor :part1, :part2, :part3, :part4

  validates_presence_of :part1, :part2, :part3, :part4

  def initialize(attributes={})
    attributes.each  do |key, value|
      self.send "#{key}=", value
    end
  end

  def code
    "#{@part1}-#{@part2}-#{@part3}-#{@part4}"
  end
end
