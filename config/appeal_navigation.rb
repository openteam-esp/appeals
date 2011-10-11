# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|

  navigation.items do |primary|
    %w[fresh registered].each do | folder |
      primary.item "sidebar_appeal_#{folder}", t("sidebar.appeal.#{folder}"), scoped_appeals_path(folder), :counter => Appeal.folder(folder).count,
                   :highlights_on => lambda { params[:folder] == folder && params[:controller] == 'appeals' }
    end
    primary.item "sidebar_appeal_closed", t("sidebar.appeal.closed"), scoped_appeals_path(:closed),
                 :highlights_on => lambda { params[:folder] == "closed" && params[:controller] == 'appeals' }
  end

end
