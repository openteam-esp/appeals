# encoding: utf-8

require 'spec_helper'

describe AppealsController do
  before do
    set_current_user user
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

    it 'folder registered' do
      Appeal.should_receive(:folder).with('registered').and_return(Appeal)
      Appeal.should_receive(:page).with(1).and_return(Appeal)

      get :index, :folder => :registered
    end

    it "folder registered with search" do
      get :index, :folder => :registered, :utf8 => true, :keywords => '10.10.2010', :page => 2

      Sunspot.session.should have_search_params(:keywords, '10.10.2010')
      Sunspot.session.should have_search_params(:with, :state, 'registered')
      Sunspot.session.should have_search_params(:paginate, :page => 2, :per_page => 15)
    end
  end

  describe 'POST revert' do
    it 'should revert registered appeal' do
      post :revert, :id => registered_appeal.id
      registered_appeal.reload.should be_fresh
      response.should redirect_to(scoped_appeals_path(:folder => :fresh))
    end

    it "should revert closed appeal" do
      post :revert, :id => closed_appeal.id
      closed_appeal.reload.should be_reviewing
      response.should redirect_to(scoped_appeals_path(:folder => :reviewing))
    end
  end

  describe 'POST close' do
    it 'should close reviewing appeal' do
      Fabricate(:reply, :appeal => reviewing_appeal)
      post :close, :id => reviewing_appeal.id
      reviewing_appeal.reload.should be_closed
      response.should redirect_to(scoped_appeals_path(:folder => :closed))
    end
  end

  describe "POST restore" do
    it 'should restore appeal' do
      post :restore, :id => deleted_appeal.id
      response.should redirect_to(scoped_appeals_path(:folder => deleted_appeal.state))
      deleted_appeal.reload.should_not be_deleted
    end
  end
end
