# == Schema Information
#
# Table name: appeals
#
#  id            :integer          not null, primary key
#  deleted_by_id :integer
#  section_id    :integer
#  topic_id      :integer
#  public        :boolean
#  deleted_at    :datetime
#  answer_kind   :string(255)
#  code          :string(255)
#  email         :string(255)
#  name          :string(255)
#  surname       :string(255)
#  patronymic    :string(255)
#  phone         :string(255)
#  root_path     :string(255)
#  social_status :string(255)
#  state         :string(255)
#  user_agent    :text
#  user_ip       :string(255)
#  user_proxy_ip :string(255)
#  user_referrer :text
#  text          :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

describe KremlinAppeal do
  it { should validate_presence_of :section }
  it { should validate_presence_of :kremlin_number }
  it { should validate_presence_of :kremlin_registered_on }

  let(:section) { Fabricate(:section) }

  let(:kremlin_appeal) {
    KremlinAppeal.new :section_id => section.id,
                      :kremlin_registered_on => '2012-01-13',
                      :kremlin_number => 'A26-13-11484',
                      :registration_attributes => { :number => '123', :registered_on => '2012-01-11' }
  }

  it "can be saved without Appeal's required fields" do
    kremlin_appeal.save!.should be_true
  end

  describe 'should generate code 2012011311484' do
    before { kremlin_appeal.save! }

    it { kremlin_appeal.code.should == '2012011311484' }
  end
end
