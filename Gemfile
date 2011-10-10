source :rubygems

gem 'cancan'
gem 'devise'
gem 'forgery',                                   :require => false
gem 'formtastic'
gem 'has_enum'
gem 'has_scope'
gem 'inherited_resources'
gem 'jquery-rails'
gem 'kaminari'
gem 'rack',                     '1.3.3'
gem 'rails'
gem 'russian',                                                                :git => 'git://github.com/tacid/russian'
gem 'ryba',                                       :require => false
gem 'state_machine'

group :production do
  gem 'pg'
end

group :development do
  gem 'guard-rspec',                              :require => false
  gem 'guard-spork',                              :require => false
  gem 'hirb',                                     :require => false
  gem 'itslog'
  gem 'libnotify',                                :require => false
  gem 'rb-inotify',                               :require => false
  gem 'ruby-graphviz',                            :require => false
  gem 'spork',                  '>= 0.9.0.rc9',   :require => false
  gem 'unicorn',                                  :require => false
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'coffee-rails',           '~> 3.1.0'
  gem 'compass',                '~> 0.12.alpha'
  gem 'sass-rails',             '~> 3.1.0'
  gem 'therubyracer'
  gem 'uglifier'
end

group :test do
  gem 'fabrication',                              :require => false
  gem 'rspec-rails',                              :require => false
  gem 'shoulda-matchers',                         :require => false
  gem 'sqlite3',                                  :require => false
  gem 'turn',                                     :require => false
end
