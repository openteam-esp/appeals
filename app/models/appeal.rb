class Appeal < ActiveRecord::Base
  has_one :address

  validates_presence_of :surname
end
