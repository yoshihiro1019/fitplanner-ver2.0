# test/controllers/gyms_controller_test.rb

require "test_helper"

class GymsControllerTest < ActionDispatch::IntegrationTest
  setup do
    # 必要に応じてユーザーを作成・ログイン
    @user = FactoryBot.create(:user)
    sign_in @user
  end

  test "should get index" do
    get gym_search_path  # 正しいパスヘルパーを使用
    assert_response :success
    # ビューの内容をテストしたい場合は追加のアサーションを
  end
end
