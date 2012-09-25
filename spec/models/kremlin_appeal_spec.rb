require 'spec_helper'

describe KremlinAppeal do
  it { should validate_presence_of :section }
  it { should validate_presence_of :kremlin_number }
  it { should validate_presence_of :kremlin_registered_on }

  let(:section) { Fabricate(:section) }

  let(:kremlin_appeal) {
    KremlinAppeal.new :section => section,
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
