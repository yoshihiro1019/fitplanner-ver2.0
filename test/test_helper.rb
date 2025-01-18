# test/test_helper.rb

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

# --- (1) WebMockの読み込み ---
require "webmock/minitest"

# デバッグログ: WebMock がロードされたことを確認
puts "WebMock loaded: #{defined?(WebMock)}"  # => "WebMock loaded: constant"

# --- (2) WebMockの設定 ---
WebMock.disable_net_connect!(allow_localhost: true)

# デバッグログ: WebMockの設定が適用されたことを確認
puts "WebMock network connections allowed: #{WebMock.net_connect_allowed?}"

stub_request(:post, "https://accounts.spotify.com/api/token").to_return(
  status: 200,
  body: { access_token: "mock_token" }.to_json,
  headers: { 'Content-Type' => 'application/json' }
)
# --- (3) stub_request の設定 ---
begin
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

  # デバッグログ: スタブが正しく設定されたことを確認
  puts "WebMock stubs have been set."
rescue => e
  # スタブ設定時にエラーが発生した場合のデバッグ
  puts "Error setting WebMock stubs: #{e.message}"
end

# --- (4) Railsのテスト設定 ---
module ActiveSupport
  class TestCase
    # 並列テストの設定
    parallelize(workers: :number_of_processors)

    # fixturesを全て読み込む
    fixtures :all

    # ここに共通で使うヘルパーメソッドを定義
  end
end

# --- (5) Deviseのヘルパーを読み込む ---
class ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
end

# デバッグログ: テストヘルパーの設定が完了したことを確認
puts "test_helper.rb setup complete."
