class BgmController < ApplicationController
  before_action :authenticate_user!

  def index
    # アクセストークンを取得
    token = fetch_spotify_token
    Rails.logger.info("Spotify token: #{token.inspect}")  # トークン確認用ログ出力

    if token
      @playlists = fetch_new_releases(token)
      Rails.logger.info("Fetched new releases: #{@playlists.inspect}")
    else
      flash[:alert] = t("bgm.index.spotify_connection_failed")
      @playlists = []
      Rails.logger.info("No token retrieved. @playlists set to empty.")
    end
  end

  private

  def fetch_spotify_token
    return "dummy_test_token" if Rails.env.test?  # テスト環境では固定値を返す

    url = URI("https://accounts.spotify.com/api/token")
    request = Net::HTTP::Post.new(url)
    request.basic_auth(
      Rails.application.credentials.spotify[:client_id],
      Rails.application.credentials.spotify[:client_secret]
    )
    request.set_form_data({
      "grant_type" => "client_credentials"
    })

    response = Net::HTTP.start(url.hostname, url.port, use_ssl: true) do |http|
      http.request(request)
    end

    Rails.logger.info("Token response status: #{response.code}")
    Rails.logger.info("Token response body: #{response.body}")

    if response.is_a?(Net::HTTPSuccess)
      JSON.parse(response.body)["access_token"]
    else
      nil
    end
  end

  def fetch_new_releases(token)
    url = URI("https://api.spotify.com/v1/browse/new-releases?limit=10")
    request = Net::HTTP::Get.new(url)
    request["Authorization"] = "Bearer #{token}"

    response = Net::HTTP.start(url.hostname, url.port, use_ssl: true) do |http|
      http.request(request)
    end

    Rails.logger.info("New Releases response status: #{response.code}")
    Rails.logger.info("New Releases response body: #{response.body}")

    if response.is_a?(Net::HTTPSuccess)
      JSON.parse(response.body)["albums"]["items"]
    else
      []
    end
  end
end
