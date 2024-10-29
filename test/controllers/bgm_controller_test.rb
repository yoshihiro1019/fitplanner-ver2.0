require "test_helper"

class BgmControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get bgm_index_url
    assert_response :success
  end
end
