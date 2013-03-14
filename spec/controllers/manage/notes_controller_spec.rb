# encoding: utf-8

require 'spec_helper'

describe Manage::RedirectsController do
  before { sign_in manager }

  describe 'POST create' do
    it 'should redirect to registered appeals' do
      post :create, :appeal_id => registered_appeal.id, :redirect => Fabricate.attributes_for(:redirect)
      response.should redirect_to(manage_scoped_appeals_path(:folder => :registered))
    end
  end
end
