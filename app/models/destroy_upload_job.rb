class DestroyUploadJob < Struct.new(:upload_id)
  def perform
    Upload.where(:uploadable_id => nil).find_by_id(upload_id).try :destroy
  end
end
