# == Schema Information
#
# Table name: registrations
#
#  id            :integer          not null, primary key
#  appeal_id     :integer
#  registered_on :date
#  number        :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

Fabricator(:registration) do
  registered_on { Date.today }
  number '13'
end
