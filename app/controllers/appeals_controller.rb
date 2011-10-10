class AppealsController < AuthorizedApplicationController
  actions :index, :show

  layout :resolve_layout

  custom_actions :resource => :revert

  has_scope :folder
  has_scope :page, :default => 1, :only => :index

  has_searcher

  def revert
    revert! {
      @appeal.revert!
      redirect_to scoped_appeals_path(:folder => @appeal.state) and return
    }
  end

  protected

    def collection
      get_collection_ivar || set_collection_ivar(search_and_paginate_collection)
    end

    def search_and_paginate_collection
      if params[:utf8]
        searcher.state = params[:folder]
        searcher.pagination = paginate_options
        searcher.results
      else
        end_of_association_chain
      end
    end

    def paginate_options(options={})
      {
        :page       => params[:page],
        :per_page   => Appeal.default_per_page
      }.merge(options)
    end

    def resolve_layout
      'system/list'
    end

end
