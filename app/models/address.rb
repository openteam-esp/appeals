#encoding: utf-8

class Address < ActiveRecord::Base
  belongs_to :appeal

  attr_accessor :use_validation

  validates_presence_of :region, :township, :district, :postcode, :street, :house, :if => :use_validation

  attr_accessible :region, :township, :district, :postcode, :street, :house, :building, :flat, :appeal_id

  validates_format_of :region, :township, :district, :with => /\A([ёЁа-яА-Я]+\s*)+\z/, :if => :use_validation, :on => :create

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
#  appeal_id  :integer
#  postcode   :string(255)
#  region     :string(255)
#  district   :string(255)
#  street     :string(255)
#  township   :string(255)
#  house      :string(255)
#  building   :string(255)
#  flat       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

