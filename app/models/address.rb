class Address < ActiveRecord::Base
  belongs_to :appeal

  attr_accessor :use_validation

  validates_presence_of :region, :township, :district, :postcode, :if => :use_validation

  def full_address
    result = []
    result << postcode if postcode.present?
    result << region if region.present?
    result << district if district.present?
    result << township if township.present?
    result << street if street.present?
    result << house if house.present?
    result << building if building.present?
    result << flat if flat.present?
    return result.join(', ')
  end
end

# == Schema Information
#
# Table name: addresses
#
#  id         :integer         not null, primary key
#  postcode   :integer
#  region     :string(255)
#  district   :string(255)
#  street     :string(255)
#  house      :string(255)
#  building   :string(255)
#  flat       :string(255)
#  created_at :datetime
#  updated_at :datetime
#
