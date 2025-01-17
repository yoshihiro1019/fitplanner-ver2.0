require 'rails_helper'

RSpec.describe "TrainingProposals", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/training_proposals/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/training_proposals/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/training_proposals/create"
      expect(response).to have_http_status(:success)
    end
  end
end
