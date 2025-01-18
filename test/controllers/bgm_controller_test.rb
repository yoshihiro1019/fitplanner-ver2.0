# test/controllers/bgm_controller_test.rb

require "test_helper"

class BgmControllerTest < ActionDispatch::IntegrationTest
  setup do
    # 必要に応じてユーザーを作成・ログイン（Devise を使用している場合）
    @user = FactoryBot.create(:user)
    sign_in @user
  end

  test "should get index" do
    get bgm_path
    assert_response :success
    # 追加のアサーションがあればここに
  end
end
