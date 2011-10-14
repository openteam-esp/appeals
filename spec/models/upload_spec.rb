# encoding: utf-8

require 'spec_helper'

describe Upload do
  it { should belong_to(:uploadable) }
  it "должна создаваться job удаления" do
    Delayed::Job.should_receive :enqueue
    Upload.create!
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

