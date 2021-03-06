# encoding: utf-8

require 'spec_helper'

describe Manage::NotesController do
  before { sign_in manager }

  describe 'POST create' do
    it 'should redirect to registered appeals' do
      post :create, :appeal_id => registered_appeal.id, :note => Fabricate.attributes_for(:note)
      response.should redirect_to(manage_scoped_appeals_path(:folder => :registered))
    end
  end
end
