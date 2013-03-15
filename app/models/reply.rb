# == Schema Information
#
# Table name: replies
#
#  id         :integer          not null, primary key
#  appeal_id  :integer
#  public     :boolean
#  replied_on :date
#  root_path  :string(255)
#  number     :string(255)
#  replied_by :string(255)
#  text       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Reply < ActiveRecord::Base
  attr_accessor :use_validation

  belongs_to :appeal

  attr_accessible :number, :replied_on, :text, :public, :replied_by, :appeal_id, :root_path

  validates_presence_of :number, :replied_on, :replied_by, :if => Proc.new { |reply| reply.use_validation }
end

