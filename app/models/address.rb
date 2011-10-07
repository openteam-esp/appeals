class Address < ActiveRecord::Base
  belongs_to :appeal

  validates_presence_of :region, :township, :district, :postcode
end
