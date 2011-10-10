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

    it "folder registred with search" do
      get :index, :folder => :registred, :utf8 => true, :keywords => '10.10.2010', :page => 2

      Sunspot.session.should have_search_params(:keywords, '10.10.2010')
      Sunspot.session.should have_search_params(:with, :state, 'registred')
      Sunspot.session.should have_search_params(:paginate, :page => 2, :per_page => 15)
    end
  end

  describe 'POST revert' do
    it 'should revert registred appeal' do
      post :revert, :id => registred_appeal.id
      registred_appeal.reload.should be_fresh
      response.should redirect_to(scoped_appeals_path(:folder => :fresh))
    end
  end

  describe 'POST reply' do
    it 'should reply registred appeal' do
      post :close, :id => registred_appeal.id
      registred_appeal.reload.should be_closed
      response.should redirect_to(scoped_appeals_path(:folder => :closed))
    end
  end
end
