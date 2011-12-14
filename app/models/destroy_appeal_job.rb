class DestroyAppealJob < Struct.new(:appeal_id)
  def perform
    Appeal.find(appeal_id).destroy
  end
end
