# encoding: utf-8

require 'spec_helper'

describe ReviewsController do
  before do
    set_current_user user
    sign_in user
  end

  describe 'POST create' do
    it 'should redirect to registered appeals' do
      post :create, :appeal_id => registered_appeal.id, :review => Fabricate.attributes_for(:review)
      response.should redirect_to(scoped_appeals_path(:folder => :registered))
    end
  end
end
