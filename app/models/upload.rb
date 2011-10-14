class Upload < ActiveRecord::Base

  attr_reader :destroy_detached_upload_job

  belongs_to :uploadable, :polymorphic => true

  after_create :create_destroy_detached_upload_job

  default_scope order :id

  upload_accessor :file do
    storage_path { "#{I18n.l Date.today, :format => "%Y/%m/%d"}/#{Time.now.to_i}-#{file_name}"}
  end

  protected

    def create_destroy_detached_upload_job
      @destroy_detached_upload_job = Delayed::Job.enqueue(:run_at => 1.day.since, :payload_object => DestroyUploadJob.new(self.id))
    end

end

# == Schema Information
#
# Table name: uploads
#
#  id             :integer         not null, primary key
#  appeal_id      :integer
#  file_name      :string(255)
#  file_mime_type :string(255)
#  file_size      :integer
#  file_uid       :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

