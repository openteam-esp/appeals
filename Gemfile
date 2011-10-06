source :rubygems

gem 'jquery-rails'
gem 'rack', '1.3.3'
gem 'rails'
gem 'russian',                                                                :git => 'git://github.com/tacid/russian'

group :production do
  gem 'pg'
end

group :development do
  gem 'guard-rspec',                              :require => false
  gem 'guard-spork',                              :require => false
  gem 'hirb',                                     :require => false
  gem 'libnotify',                                :require => false
  gem 'rb-inotify',                               :require => false
  gem 'ruby-graphviz',                            :require => false
  gem 'spork',                  '>= 0.9.0.rc9',   :require => false
  gem 'unicorn',                                  :require => false
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  #gem 'coffee-rails', "~> 3.1.0"
  gem 'sass-rails', "  ~> 3.1.0"
  #gem 'uglifier'
end

group :test do
  gem 'sqlite3',                                  :require => false
  gem 'fabrication',                              :require => false
  gem 'rspec-rails',                              :require => false
  gem 'shoulda-matchers',                         :require => false
  gem 'turn', :require => false
end
