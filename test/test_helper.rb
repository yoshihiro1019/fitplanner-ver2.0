# test/test_helper.rb

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

# --- (1) WebMockの読み込み & 設定 ---
require "webmock/minitest"      # Minitest で WebMock を使うため
WebMock.disable_net_connect!(
  allow_localhost: true         # ローカルのテストサーバ(例: Selenium/Capybara)を許可
)

# 必要に応じて、ここでAPIのスタブを定義しておく
# 例: Spotify APIをモックする
stub_request(:post, "https://accounts.spotify.com/api/token").to_return(
  status: 200,
  body: { access_token: "dummy_token_for_tests" }.to_json,
  headers: { "Content-Type" => "application/json" }
)

stub_request(:get, "https://api.spotify.com/v1/browse/new-releases?limit=10").to_return(
  status: 200,
  body: {
    albums: {
      items: [
        { "name" => "Mock Album 1" },
        { "name" => "Mock Album 2" }
      ]
    }
  }.to_json,
  headers: { "Content-Type" => "application/json" }
)

module ActiveSupport
  class TestCase
    # --- (2) 並列テスト設定 ---
    parallelize(workers: :number_of_processors)
    
    # --- (3) fixtures を読み込む場合 ---
    fixtures :all
    
    # ここに共通で使うヘルパーメソッドを定義してもよい
  end
end

# --- (4) DeviseのIntegrationHelpersを読み込む ---
class ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
end

# --- (5) (任意) Capybara/SystemTest設定 ---
# require "capybara/rails"
# class ActionDispatch::SystemTestCase
#   driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
# end
