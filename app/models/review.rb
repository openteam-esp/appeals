class Review < ActiveRecord::Base
  belongs_to :appeal

  after_create :review_appeal

  private
    def review_appeal
      self.appeal.to_review!
    end
end
