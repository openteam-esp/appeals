# encoding: utf-8

require 'spec_helper'

describe AppealsController do
  describe "POST create" do
    it "должен проставлять техническую информацию" do
      appeal_attributes = Fabricate.build(:appeal, :section => section).attributes.keep_if{|k,v| v}
      appeal_attributes.delete('section_id')
      post :create, :appeal => appeal_attributes, :section_id => section.id
      appeal = assigns(:appeal)
      response.should redirect_to(appeal_path(appeal.code))
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

