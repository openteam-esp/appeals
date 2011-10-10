# encoding: utf-8

require 'spec_helper'

describe Address do
  it { should belong_to(:appeal) }
  it { should validate_presence_of(:postcode) }
  it { should validate_presence_of(:region) }
  it { should validate_presence_of(:district) }
  it { should validate_presence_of(:township) }
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

