class KremlinAppeal < Appeal
  validates_presence_of :kremlin_number, :kremlin_registered_on

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
