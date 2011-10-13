class AppealsController < AuthorizedApplicationController
  actions :index, :show, :destroy

  layout :resolve_layout

  custom_actions :resource => [:close, :restore, :revert]

  has_scope :folder
  has_scope :page, :default => 1, :only => :index

  has_searcher

  def revert
    revert! {
      @appeal.to_revert!
      redirect_to scoped_appeals_path(:folder => @appeal.state) and return
    }
  end

  def close
    close! {
      @appeal.to_close!
      redirect_to scoped_appeals_path(:folder => @appeal.state) and return
    }
  end

  def destroy
    destroy! { scoped_appeals_path(:folder => @appeal.state) }
  end

  def restore
    restore! {
      @appeal.restore
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
      return 'system/appeal' if action_name == 'show'
      'system/list'
    end

end
