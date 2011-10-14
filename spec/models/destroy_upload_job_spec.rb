# encoding: utf-8

require 'spec_helper'

describe DestroyUploadJob do
  let(:upload) { Upload.create! }
  let(:job) { upload.destroy_detached_upload_job }

  describe "у несвязанного файла" do
    it { job.should be_a(Delayed::Backend::ActiveRecord::Job) }
    it { job.should be_persisted }
    it "после выполнения удаляет файл" do
      upload
      expect{ job.invoke_job }.to change{Upload.count}.by(-1)
    end
  end
  describe "у привязанного файла" do
    before { upload.update_attribute :uploadable, Fabricate(:appeal) }
    it "после выполнения не удаляет файл" do
      upload
      expect{ job.invoke_job }.to_not change{Upload.count}.by(-1)
    end
  end
end

