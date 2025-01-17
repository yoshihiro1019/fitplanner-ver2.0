require 'rails_helper'

RSpec.describe "TrainingLogs", type: :system do
  let!(:user) { create(:user) }
  let!(:training_log) { create(:training_log, user: user) }

  before do
    # ログインが必要な場合はここでログイン手順を実行
    # visit new_user_session_path
    # fill_in 'Email', with: user.email
    # fill_in 'Password', with: user.password
    # click_button 'Log in'
  end
end
