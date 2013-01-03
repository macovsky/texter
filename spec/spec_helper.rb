ENV['RAILS_ENV'] = 'test'

require File.expand_path('../dummy/config/environment.rb',  __FILE__)

require 'rspec/rails'
require 'capybara/rspec'
require 'capybara-webkit'
require 'database_cleaner'

Capybara.default_selector = :css
Capybara.javascript_driver = :webkit

Rails.backtrace_cleaner.remove_silencers!

ENGINE_RAILS_ROOT=File.join(File.dirname(__FILE__), '../')

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.use_transactional_fixtures = false

  config.before :each do
    if Capybara.current_driver == :rack_test
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.start
    else
      DatabaseCleaner.strategy = :truncation
    end
  end

  config.after :each do
    DatabaseCleaner.clean
  end
end
