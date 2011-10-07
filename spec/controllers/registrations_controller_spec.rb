require 'spec_helper'

describe RegistrationsController do
  before do
    set_current_user
    sign_in user
  end

  it "POST create" do
    post :create, :appeal_id => fresh_appeal.id, :registration => Fabricate.attributes_for(:registration)
    response.should redirect_to(assigns(:appeal))
  end
end
