# encoding: utf-8

require 'spec_helper'

describe AppealsController do
  before do
    set_current_user
    sign_in user
  end

  it "GET index folder fresh" do
    Appeal.should_receive(:folder).with('fresh').and_return(Appeal)
    get :index, :folder => :fresh
  end


end
