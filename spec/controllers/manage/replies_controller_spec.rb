require 'spec_helper'

describe Manage::RepliesController do
  before { sign_in manager }

  it "POST create" do
    post :create, :appeal_id => reviewing_appeal.id, :reply => Fabricate.attributes_for(:reply)
    response.should render_template('replies/_reply')
  end

  it "PUT update" do
    reply = Fabricate(:reply, :appeal => reviewing_appeal)
    put :update, :appeal_id => reviewing_appeal.id, :reply => Fabricate.attributes_for(:reply)
    response.should render_template('replies/_reply')
  end
end
