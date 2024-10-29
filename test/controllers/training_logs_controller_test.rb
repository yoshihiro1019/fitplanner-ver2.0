require "test_helper"

class TrainingLogsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get training_logs_index_url
    assert_response :success
  end
end
