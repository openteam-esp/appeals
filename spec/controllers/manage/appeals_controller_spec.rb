# encoding: utf-8

require 'spec_helper'

describe Manage::AppealsController do
  before { sign_in manager }

  describe 'GET index' do
    it 'folder fresh' do
      Appeal.should_receive(:folder).with('fresh').at_least(1).times.and_return(Appeal)
      Appeal.should_receive(:page).with(1).at_least(1).times.and_return(Appeal)

      get :index, :folder => :fresh
    end

    it 'second page folder fresh' do
      Appeal.should_receive(:folder).with('fresh').at_least(1).times.and_return(Appeal)
      Appeal.should_receive(:page).with('2').at_least(1).times.and_return(Appeal)

      get :index, :folder => :fresh, :page => 2
    end

    it 'folder registered' do
      Appeal.should_receive(:folder).with('registered').at_least(1).times.and_return(Appeal)
      Appeal.should_receive(:page).with(1).at_least(1).times.and_return(Appeal)

      get :index, :folder => :registered
    end

    it "folder registered with search" do
      get :index, :folder => :registered, :utf8 => true, :keywords => '10.10.2010', :page => 2

      Sunspot.session.should have_search_params(:keywords, '10.10.2010')
      Sunspot.session.should have_search_params(:with, :state, 'registered')
      Sunspot.session.should have_search_params(:paginate, :page => 2, :per_page => 15)
    end
  end

  describe 'DELETE destroy' do
    before { delete :destroy, :id => fresh_appeal }

    subject { fresh_appeal.reload }

    it { should be_persisted }
    it { should be_deleted }
    its(:deleted_by) { should == assigns(:current_user) }
  end

  describe 'POST close' do
    it 'should close reviewing appeal' do
      Appeal.any_instance.stub(:reply_valid?).and_return(true)
      post :close, :id => reviewing_appeal.id

      reviewing_appeal.reload.should be_closed
      response.should redirect_to(manage_scoped_appeals_path(:folder => :reviewing))
    end
  end

  describe "POST restore" do
    it 'should restore appeal' do
      post :restore, :id => deleted_appeal.id

      deleted_appeal.reload.should_not be_deleted
      response.should redirect_to(manage_scoped_appeals_path(:folder => deleted_appeal.state))
    end
  end

  describe 'POST revert for' do
    describe 'registered appeal' do
      before { post :revert, :id => registered_appeal }

      it { registered_appeal.reload.should be_fresh }
      it { response.should redirect_to(manage_scoped_appeals_path(:folder => :fresh)) }
    end

    describe 'noted appeal' do
      before { post :revert, :id => noted_appeal }

      it { noted_appeal.reload.should be_registered }
      it { response.should redirect_to(manage_scoped_appeals_path(:folder => :registered)) }
    end

    describe 'closed appeal' do
      before { post :revert, :id => closed_appeal }

      it { closed_appeal.reload.should be_reviewing }
      it { response.should redirect_to(manage_scoped_appeals_path(:folder => :reviewing)) }
    end
  end
end
