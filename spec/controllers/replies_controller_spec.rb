require 'spec_helper'

describe RepliesController do
  before do
    set_current_user
    sign_in user
  end

  it "POST create" do
    post :create, :appeal_id => registred_appeal.id, :reply => Fabricate.attributes_for(:reply)
    response.should redirect_to(assigns(:appeal))
  end

  it "PUT update" do
    reply = Fabricate(:reply, :appeal => registred_appeal)
    put :update, :appeal_id => registred_appeal.id, :reply => Fabricate.attributes_for(:reply)
    response.should redirect_to(assigns(:appeal))
  end
end
