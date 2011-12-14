require 'spork'

Spork.prefork do
  # This file is copied to spec/ when you run 'rails generate rspec:install'
  ENV["RAILS_ENV"] ||= 'test'

  require File.expand_path("../../config/environment", __FILE__)

  require 'rspec/rails'

  require "cancan/matchers"
  require 'shoulda-matchers'
  require 'sunspot_matchers'

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/helpers/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.include AppealsSpecHelper
    config.include Devise::TestHelpers, :type => :controller
    config.include SunspotMatchers

    config.mock_with :rspec

    config.use_transactional_fixtures = true

    config.before(:all) do
      require 'fabrication'

      Dir[Rails.root.join("spec/support/matchers/*.rb")].each {|f| require f}
      Sunspot.session = SunspotMatchers::SunspotSessionSpy.new(Sunspot.session)
    end
  end
end
