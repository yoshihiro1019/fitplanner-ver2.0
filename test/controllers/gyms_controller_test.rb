require "test_helper"

class GymsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get gym_search_path
    assert_response :success
  end
end
