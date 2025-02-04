require 'rails_helper'

RSpec.describe "TrainingSuggestions", type: :request do
  let!(:user) { create(:user) } # Devise のログインユーザー
  let(:headers) { { "ACCEPT" => "application/json" } }

  before do
    sign_in user # Devise のログイン処理
  end

  it "部位として胸を選択すると、胸のトレーニングが取得できる" do
    post training_suggestions_path, params: { body_part_code: "chest" }, headers: headers

    # レスポンスの中身を出力
    puts "レスポンスボディ: #{response.body}"

    json_response = JSON.parse(response.body)

    expect(json_response["suggestions"].map { |s| s["name"] }).to include("ベンチプレス")
  end
end
