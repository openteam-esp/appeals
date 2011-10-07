# encoding: utf-8

require 'spec_helper'

describe Public::AppealsController do
  describe "POST create" do
    it "должен проставлять техническую информацию" do
      appeal_attributes = Fabricate.attributes_for(:appeal)
      appeal_attributes[:topic_id] = appeal_attributes[:topic]
      appeal_attributes.delete(:topic)
      post :create, :appeal => appeal_attributes
      appeal = assigns(:appeal)
      response.should redirect_to(public_appeal_path(appeal))
      appeal.user_ip.should_not be_nil
      appeal.user_agent.should_not be_nil
    end
  end
end

