require "test_helper"

class MypagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    # テスト用のユーザを作成（FactoryBot がなければ fixtures などでもOK）
    @user = FactoryBot.create(:user)
    # Devise のヘルパーメソッドでログイン
    sign_in @user
  end

  test "should get show" do
    get mypage_path
    assert_response :success
  end
end

