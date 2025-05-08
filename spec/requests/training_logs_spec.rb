require 'rails_helper'

RSpec.describe "TrainingLogs", type: :request do
  let(:user) { create(:user) }

  before do
    sign_in user  # Deviseのログインヘルパーを使用
  end

  describe "GET /training_logs" do
    it "一覧ページに正常にアクセスできること" do
      get training_logs_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /training_logs" do
    let(:valid_params) do
      { training_log: { training_type: 'Bench Press', weight: 50, reps: 10, sets: 3, day_of_week: 'Monday' } }
    end

    it "新規作成ができること" do
      expect {
        post training_logs_path, params: valid_params
      }.to change(TrainingLog, :count).by(1)
      expect(response).to redirect_to(training_logs_path(TrainingLog.last))
    end
  end

  describe "TrainingLogs 編集ページから正しく編集できること", type: :request do
    let(:user) { create(:user) }
    let(:training_log) { create(:training_log, user: user) }

    before do
      sign_in user # Deviseのサインインヘルパー
    end

    it "編集後に正しくリダイレクトされること" do
      patch training_log_path(training_log), params: { training_log: { training_type: "Squat" } }
      expect(response).to redirect_to(training_logs_path)

      follow_redirect!
      expect(response.body).to include("トレーニング記録が更新されました")
      expect(response.body).to include("Squat")
    end
  end

  describe "TrainingLogs 一覧画面から削除すると記録が消えること", type: :request do
    let(:user) { create(:user) }
    let!(:training_log) { create(:training_log, user: user) }

    before do
      sign_in user
    end

    it "削除後に正しいレスポンスが返ること" do
      expect {
        delete training_log_path(training_log)
      }.to change(TrainingLog, :count).by(-1)

      expect(response).to redirect_to(training_logs_path)

      follow_redirect!
      expect(response.body).to include("トレーニング記録が削除されました")
    end
  end
end
