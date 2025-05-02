# require 'rails_helper'

# RSpec.describe "TrainingSuggestions", type: :request do
# describe "部位別トレーニングの取得" do
# #let(:user) { create(:user) } # ユーザーを作成
# let(:headers) { { "ACCEPT" => "application/json" } }

# before do
# sign_in user  # ユーザーが必要ならログインする
# end

# it "部位として胸を選択すると、胸のトレーニングが取得できる" do
# post training_suggestions_path, params: { body_part_code: "chest" }, headers: headers

# puts "レスポンスボディ: #{response.body}"  # デバッグ
# puts "レスポンスステータス: #{response.status}"  # HTTP ステータスコードを確認

# json_response = JSON.parse(response.body)
# expect(json_response["suggestions"].map { |s| s["name"] }).to include("ベンチプレス")
# end
# end
# end
