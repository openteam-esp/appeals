# == Schema Information
#
# Table name: addresses
#
#  id         :integer          not null, primary key
#  appeal_id  :integer
#  postcode   :string(255)
#  region     :string(255)
#  district   :string(255)
#  street     :string(255)
#  township   :string(255)
#  house      :string(255)
#  building   :string(255)
#  flat       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Address do
end
