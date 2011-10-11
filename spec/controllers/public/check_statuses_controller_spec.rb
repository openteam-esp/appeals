# encoding: utf-8

require 'spec_helper'

describe Public::CheckStatusesController do
  it "get new" do
    get :new
    response.should render_template(:new)
  end

  describe "POST create" do
    it "если найдено обращение" do
      post :create, :check_status => fresh_appeal.code.split("-").inject({}) {|options, part| options["part#{options.size+1}"] = part; options}
      response.should redirect_to(public_appeal_path(fresh_appeal.code))
    end

    it "если обращение не найдено" do
      post :create, :check_status => {:part1 => "123", :part2 => "123", :part3 => "123", :part4 => "123"}
      response.should render_template(:new)
    end
  end

end

