require 'fabrication'
require 'forgery'
require 'ryba'

section = Section.find_or_create_by_title('Section #1')

%w[Topic1 Topic2 Topic3].each do |title|
  section.topics.find_or_create_by_title title
end

User.find_or_initialize_by_email('demo@demo.de').tap do | user |
  if user.new_record?
    user.update_attributes :password => '123123',
      :password_confirmation => '123123',
      :name => Ryba::Name.full_name
  end
end

Appeal.destroy_all
10.times do
  options = rand(4) > 1 ? {:answer_kind => 'email'} : {:answer_kind => 'post', :email => rand(2) > 1 ? nil : Forgery(:internet).email_address }
  appeal = Fabricate.build(:appeal, options)
  appeal.address_attributes = Fabricate.attributes_for(:address) if appeal.answer_kind_post?
  appeal.save!
  appeal.dispatch!
end
