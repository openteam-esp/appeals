# encoding: utf-8

require 'spec_helper'

describe AppealsController do
  before do
    set_current_user
    sign_in user
  end

  describe "GET index" do
    it "folder fresh" do
      Appeal.should_receive(:folder).with('fresh').and_return(Appeal)
      get :index, :folder => :fresh
    end
  end

  describe "POST revert" do
    it "should revert registred appeal" do
      post :revert, :id => registred_appeal.id
      registred_appeal.reload.should be_fresh
      response.should redirect_to(scoped_appeals_path(:folder => :fresh))
    end
  end
end
