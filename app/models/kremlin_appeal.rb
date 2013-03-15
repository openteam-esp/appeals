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

class KremlinAppeal < Appeal
  validates_presence_of :kremlin_number, :kremlin_registered_on
  attr_accessible :kremlin_registered_on, :kremlin_number, :section_id, :registration_attributes

  accepts_nested_attributes_for :registration

  protected

  def validate_basic_fields?
    false
  end

  def generate_code
    "#{pure_date}#{last_part_of_kremlin_number}"
  end

  def pure_date
    kremlin_registered_on.strftime('%Y%m%d')
  end

  def last_part_of_kremlin_number
    kremlin_number.split('-').last
  end
end
