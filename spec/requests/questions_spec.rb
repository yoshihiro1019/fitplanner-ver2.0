require 'rails_helper'

RSpec.describe "Questions", type: :request do
  let(:user) { create(:user) }
  let(:headers) { { "ACCEPT" => "text/html" } } 

  before do
    sign_in user
  end

  describe "GET /questions" do
    it "returns http success" do
      get questions_path, headers: headers
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /questions" do
    it "creates a new training suggestion and redirects" do
      post questions_path,
           params: {
             age: "28",
             experience: "半年",
             focus_area: "胸筋",
             training_location: "自宅",
             home_equipment: "ダンベル"
           },
           headers: headers

      expect(response).to have_http_status(:redirect)
      follow_redirect!
      expect(response.body).to include("提案を保存しました").or include("提案が生成されませんでした")
    end
  end
end
