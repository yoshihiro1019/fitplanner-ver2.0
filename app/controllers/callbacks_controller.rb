class CallbacksController < ApplicationController
    require "rest-client"
    require "json"

    def callback
      code = params[:code]

      # クライアントIDとシークレットを取得
      client_id = Rails.application.credentials.spotify[:client_id]
      client_secret = Rails.application.credentials.spotify[:client_secret]

      # アクセストークンを取得
      token_response = RestClient.post("https://accounts.spotify.com/api/token", {
        grant_type: "authorization_code",
        code: code,
        redirect_uri: "http://localhost:3000/callback", # リダイレクトURI
        client_id: client_id,
        client_secret: client_secret
      })

      token_info = JSON.parse(token_response.body)
      access_token = token_info["access_token"]

      # アクセストークンを使ってユーザー情報を取得
      user_response = RestClient.get("https://api.spotify.com/v1/me", {
        Authorization: "Bearer #{access_token}"
      })

      user_info = JSON.parse(user_response.body)

      render json: user_info
    rescue RestClient::ExceptionWithResponse => e
      error_info = JSON.parse(e.response)
      render json: error_info, status: e.response.code
    end
end
