ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

# --- (1) VCRの読み込み ---
require "vcr"

# --- (2) VCRの設定 ---
VCR.configure do |config|
  # HTTPリクエストをフックするライブラリとしてWebMockを使用
  config.hook_into :webmock
  # ローカルホストへのリクエストを許可
  config.ignore_localhost = true
  # キャプチャしたリクエストを保存するディレクトリ
  config.cassette_library_dir = "test/vcr_cassettes"
  # デバッグログ用
  config.debug_logger = File.open("log/vcr.log", "w")
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
puts "test_helper.rb setup complete with VCR."
