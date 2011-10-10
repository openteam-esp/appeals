class AppealsController < AuthorizedApplicationController
  actions :index, :show

  custom_actions :resource => :revert

  has_scope :folder
  has_scope :page, :default => 1, :only => :index

  def revert
    revert! {
      @appeal.revert!
      redirect_to scoped_appeals_path(:folder => @appeal.state) and return
    }
  end
end
