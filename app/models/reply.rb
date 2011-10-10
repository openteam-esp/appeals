class Reply < ActiveRecord::Base
  belongs_to :appeal
end

# == Schema Information
#
# Table name: replies
#
#  id         :integer         not null, primary key
#  number     :string(255)
#  replied_on :date
#  text       :text
#  public     :boolean
#  replied_by :string(255)
#  appeal_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

