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

require 'forgery'
require 'ryba'

Fabricator(:reply) do
  number      Appeal.new.send(:generate_code, 6, 3, '-')
  replied_on  { Date.today }
  text        { Forgery(:lorem_ipsum).words(10) }
  public      false
  replied_by  { Ryba::Name.full_name }
end
