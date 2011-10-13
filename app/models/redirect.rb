class Redirect < ActiveRecord::Base
  belongs_to :appeal

  after_create :redirect_appeal

  private
    def redirect_appeal
      self.appeal.to_redirect!
    end
end
