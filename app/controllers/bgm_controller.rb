# app/controllers/bgm_controller.rb

require "net/http"
require "json"

class BgmController < ApplicationController
  def index
    # アクセストークンを取得
    token = fetch_spotify_token
    if token
      # "ワークアウト"プレイリストをランダムに取得
      @playlist = fetch_workout_playlist(token)
    else
      flash[:alert] = "Spotify APIへの接続に失敗しました。"
    end
  end

  private

  def fetch_spotify_token
    url = URI("https://accounts.spotify.com/api/token")
    request = Net::HTTP::Post.new(url)
    request.basic_auth(Rails.application.credentials.spotify[:client_id], Rails.application.credentials.spotify[:client_secret])
    request.set_form_data({
      "grant_type" => "client_credentials"
    })

    response = Net::HTTP.start(url.hostname, url.port, use_ssl: true) do |http|
      http.request(request)
    end

    if response.is_a?(Net::HTTPSuccess)
      JSON.parse(response.body)["access_token"]
    else
      nil
    end
  end

  def fetch_workout_playlist(token)
    url = URI("https://api.spotify.com/v1/browse/categories/workout/playlists?country=JP&limit=10")
    request = Net::HTTP::Get.new(url)
    request["Authorization"] = "Bearer #{token}"

    response = Net::HTTP.start(url.hostname, url.port, use_ssl: true) do |http|
      http.request(request)
    end

    if response.is_a?(Net::HTTPSuccess)
      playlists = JSON.parse(response.body)["playlists"]["items"]
      playlists.sample # ランダムに1つ選ぶ
    else
      nil
    end
  end
end
