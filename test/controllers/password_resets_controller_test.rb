require "test_helper"

class PasswordResetsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_password_reset_path
    assert_response :success
  end

  test "should get create" do
    post password_reset_path, params: { ... }
    assert_response :success
  end
end
