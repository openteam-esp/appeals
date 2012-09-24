class KremlinAppeal < Appeal
  validates_presence_of :kremlin_number, :kremlin_registered_on

  def validate_basic_fields?
    false
  end
end
