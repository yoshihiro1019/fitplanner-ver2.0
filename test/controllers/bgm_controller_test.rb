require "test_helper"

class BgmControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = FactoryBot.create(:user)
    sign_in @user
  end

  test "should get index with Spotify API mock" do
    # VCRを利用してSpotify APIのリクエストをモック
    VCR.use_cassette("spotify_token") do
      get bgm_path
      assert_response :success
    end
  end
end

