class GymsController < ApplicationController
  require "net/http"
  require "json"
  before_action :authenticate_user!
  def index
    if params[:latitude].present? && params[:longitude].present?
      latitude = params[:latitude].to_f
      longitude = params[:longitude].to_f
      radius = params[:radius].present? ? params[:radius].to_i : 5000 # 半径5kmデフォルト

      @gyms = fetch_nearby_gyms(latitude, longitude, radius)
    else
      @gyms = []
    end
  end

  private

  def fetch_nearby_gyms(latitude, longitude, radius)
    api_key = ENV["GOOGLE_MAPS_API_KEY"]
    url = URI("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{latitude},#{longitude}&radius=#{radius}&type=gym&key=#{api_key}")

    response = Net::HTTP.get(url)
    result = JSON.parse(response)

    if result["status"] == "OK"
      result["results"]
    else
      []
    end
  end
end
