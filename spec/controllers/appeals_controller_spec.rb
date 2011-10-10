# encoding: utf-8

require 'spec_helper'

describe AppealsController do
  before do
    set_current_user
    sign_in user
  end

  describe 'GET index' do
    it 'folder fresh' do
      Appeal.should_receive(:folder).with('fresh').and_return(Appeal)
      get :index, :folder => :fresh
    end

    it 'second page folder fresh' do
      Appeal.should_receive(:folder).with('fresh').and_return(Appeal)
      Appeal.should_receive(:page).with('2').and_return(Appeal)
      get :index, :folder => :fresh, :page => 2
    end

    it 'folder registred' do
      Appeal.should_receive(:folder).with('registred').and_return(Appeal)
      Appeal.should_receive(:page).with(1).and_return(Appeal)
      get :index, :folder => :registred
    end
  end

  describe 'POST revert' do
    it 'should revert registred appeal' do
      post :revert, :id => registred_appeal.id
      registred_appeal.reload.should be_fresh
      response.should redirect_to(scoped_appeals_path(:folder => :fresh))
    end
  end
end
