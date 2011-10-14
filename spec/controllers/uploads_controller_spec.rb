# encoding: utf-8

require 'spec_helper'

describe UploadsController do
  before do
    set_current_user
    sign_in user
  end

  let(:reply) { Fabricate(:reply, :appeal => reviewing_appeal)}
  let(:file) { File.open(__FILE__) }
  let(:upload) { Upload.create! :file => file, :uploadable => reviewing_appeal }
  describe "POST create" do
    def post_create
      post :create, :reply_id => reply.id, :upload => { :file => file }
    end
    it { expect{post_create}.to change{reply.uploads.count}.by(1) }
    describe 'response' do
      before { post_create }
      let(:subject) { response }
      it { should be_success }
      it { should render_template('uploads/_upload_form') }
    end
  end

  describe "DELETE destroy" do
    before { delete :destroy, :id => upload.id }
    it { Upload.find_by_id(upload).should be_nil }
    describe 'response' do
      let(:subject) { response }
      it { should be_success }
      it { should render_template('uploads/_upload_form') }
    end
  end
end
