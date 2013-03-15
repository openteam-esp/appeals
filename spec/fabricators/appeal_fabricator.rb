# == Schema Information
#
# Table name: appeals
#
#  id            :integer          not null, primary key
#  deleted_by_id :integer
#  section_id    :integer
#  topic_id      :integer
#  public        :boolean
#  deleted_at    :datetime
#  answer_kind   :string(255)
#  code          :string(255)
#  email         :string(255)
#  name          :string(255)
#  surname       :string(255)
#  patronymic    :string(255)
#  phone         :string(255)
#  root_path     :string(255)
#  social_status :string(255)
#  state         :string(255)
#  user_agent    :text
#  user_ip       :string(255)
#  user_proxy_ip :string(255)
#  user_referrer :text
#  text          :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'forgery'
require 'ryba'

Fabricator(:appeal) do
  author      { Ryba::Name.full_name }
  phone       { Ryba::PhoneNumber.phone_number }
  email       { Forgery(:internet).email_address }
  text        { Forgery(:lorem_ipsum).words(5) }
  answer_kind 'email'
  topic!
  section!
end
