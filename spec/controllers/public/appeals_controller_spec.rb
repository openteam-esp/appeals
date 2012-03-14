# encoding: utf-8

require 'spec_helper'

describe Public::AppealsController do
  describe "POST create" do
    it "должен проставлять техническую информацию" do
      appeal_attributes = Fabricate.attributes_for(:appeal)
      appeal_attributes.merge(:section_id => section)
      appeal_attributes[:topic_id] = appeal_attributes[:topic]
      appeal_attributes.delete(:topic)
      post :create, :appeal => appeal_attributes, :section_id => section.id
      appeal = assigns(:appeal)
      response.should redirect_to(public_appeal_path(appeal.code))
      appeal.user_ip.should_not be_nil
      appeal.user_agent.should_not be_nil
    end
  end

  describe "GET show" do
    it "если обращение найдено" do
      get :show, :id => registered_appeal.code
      assigns(:appeal).should == registered_appeal
      response.should render_template("show")
    end

    it "если обращение не найдено" do
      get :show, :id => "1234454"
      assigns(:appeal).should be_nil
      response.should render_template("show")
    end
  end
end

