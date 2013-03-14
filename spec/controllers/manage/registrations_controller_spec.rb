require 'spec_helper'

describe Manage::RegistrationsController do
  before { sign_in manager }

  it "POST create" do
    post :create, :appeal_id => fresh_appeal.id, :registration => Fabricate.attributes_for(:registration)
    response.should redirect_to(manage_scoped_appeals_path(:folder => :fresh))
  end
end
