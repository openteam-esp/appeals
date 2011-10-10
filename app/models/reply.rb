class Reply < ActiveRecord::Base
  attr_accessor :use_validation

  belongs_to :appeal

  validates_presence_of :number, :replied_on, :replied_by, :text, :if => Proc.new { | reply | reply.use_validation}
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

