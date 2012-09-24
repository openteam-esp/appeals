require 'spec_helper'

describe KremlinAppeal do
  it { should validate_presence_of :kremlin_number }
  it { should validate_presence_of :kremlin_registered_on }

  let(:section) { Fabricate(:section) }
  let(:topic) { Fabricate(:topic) }

  subject {
    KremlinAppeal.new :section => section,
                      :topic => topic,
                      :kremlin_registered_on => '2012-01-13',
                      :kremlin_number => 'A26-13-11484'
  }

  it "can be saved without Appeal's required fields" do
    subject.save!.should be_true
  end
end
