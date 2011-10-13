# -*- coding: utf-8 -*-

# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    %w[fresh registered reviewing closed noted redirected trash].each do | folder |
      primary.item "sidebar_appeal_#{folder}",
                   t("sidebar.appeal.#{folder}"),
                   scoped_appeals_path(folder),
                   :counter => %w[closed noted redirected].include?(folder) ? ' ' : Appeal.folder(folder).count,
                   :highlights_on => lambda { params[:folder] == folder && params[:controller] == 'appeals' }
    end
  end
end
