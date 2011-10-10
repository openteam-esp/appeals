require 'spec_helper'

describe Reply do
  pending "add some examples to (or delete) #{__FILE__}"
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

