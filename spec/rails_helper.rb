# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'openai'
OpenAI.configure do |config|
  config.access_token = 'dummy_test_token'
end

require 'rspec/rails'
require 'factory_bot_rails'
require 'capybara/rspec'
require 'selenium/webdriver'
require 'database_cleaner/active_record'

# FactoryBot の設定
RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end

# Devise のテストヘルパーをリクエストスペックで使用可能に
RSpec.configure do |config|
  config.include Devise::Test::IntegrationHelpers, type: :request
end

# Capybara の設定
Capybara.register_driver :selenium_chrome_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-dev-shm-usage')
  options.add_argument('--disable-gpu')
  options.add_argument('--disable-software-rasterizer')
  options.add_argument('--remote-debugging-port=9222')
  options.add_argument('--disable-extensions')
  options.add_argument('--disable-background-networking')

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end



Capybara.javascript_driver = :selenium_chrome_headless

# Capybara のデフォルト設定
RSpec.configure do |config|
  config.before(:suite) do
    Capybara.server = :puma, { Silent: true }
    Capybara.default_max_wait_time = 5 # Ajax の待ち時間を確保
  end
end

# DatabaseCleaner の設定
RSpec.configure do |config|
  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.append_after(:each) do
    DatabaseCleaner.clean
  end
end

# spec/fixtures を fixture_path に設定
RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
end

# `spec/` 内のファイルの位置に応じた spec type を推測
RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
end

# RSpec の出力を見やすくする
RSpec.configure do |config|
  config.filter_rails_from_backtrace!
end
