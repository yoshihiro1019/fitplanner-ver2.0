require "test_helper"

class GymsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get gyms_index_path
    assert_response :success
  end
end
