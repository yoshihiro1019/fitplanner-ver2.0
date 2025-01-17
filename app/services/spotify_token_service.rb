# app/services/spotify_token_service.rb
class SpotifyTokenService
    require "net/http"
    require "json"

    TOKEN_URL = URI("https://accounts.spotify.com/api/token")

    def self.access_token
      if token_expired?
        fetch_access_token
      else
        Rails.cache.read("spotify_access_token")
      end
    end

    private

    def self.fetch_access_token
      request = Net::HTTP::Post.new(TOKEN_URL)
      request.basic_auth(
        Rails.application.credentials.spotify[:client_id],
        Rails.application.credentials.spotify[:client_secret]
      )
      request.set_form_data({ "grant_type" => "client_credentials" })

      response = Net::HTTP.start(TOKEN_URL.hostname, TOKEN_URL.port, use_ssl: true) do |http|
        http.request(request)
      end

      if response.is_a?(Net::HTTPSuccess)
        data = JSON.parse(response.body)
        access_token = data["access_token"]
        expires_in = data["expires_in"]

        # トークンと有効期限をキャッシュに保存
        Rails.cache.write("spotify_access_token", access_token, expires_in: expires_in.seconds)
        Rails.cache.write("spotify_token_expiration_time", Time.now + expires_in.seconds, expires_in: expires_in.seconds)

        access_token
      else
        Rails.logger.error("Spotifyトークン取得エラー: #{response.code} - #{response.body}")
        nil
      end
    end

    def self.token_expired?
      expiration_time = Rails.cache.read("spotify_token_expiration_time")
      expiration_time.nil? || Time.now >= expiration_time
    end
end
