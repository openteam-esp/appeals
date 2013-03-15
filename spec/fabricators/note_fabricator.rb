# == Schema Information
#
# Table name: notes
#
#  id         :integer          not null, primary key
#  appeal_id  :integer
#  public     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

Fabricator(:note) do
  public false
end
