require "test_helper"

class TrainingLogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    # 例: FactoryBot でユーザーを作成
    @user = FactoryBot.create(:user)

    # Devise のヘルパーでログイン状態にする
    sign_in @user
  end

  test "should get index" do
    get training_logs_path
    assert_response :success
  end
end
