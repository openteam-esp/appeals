# encoding: utf-8
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


require 'spec_helper'

describe Reply do
end
