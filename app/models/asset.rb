class Asset < ActiveRecord::Base
  def to_s
    id.to_s
  end
end
# == Schema Information
#
# Table name: assets
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

