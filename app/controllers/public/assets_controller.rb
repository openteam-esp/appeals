class Public::AssetsController < ApplicationController

  def create
    session[:asset_ids] ||= []
    session[:asset_ids] << Asset.create!.id
    @assets = Asset.find(session[:asset_ids])
    render @assets
  end

end
