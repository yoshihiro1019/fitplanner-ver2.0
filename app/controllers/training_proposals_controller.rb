class TrainingProposalsController < ApplicationController
  def index
  end

  def new
  end

  def create
  end

  def history
    # 履歴表示用アクション
    @training_proposals = TrainingProposal.order(created_at: :desc)
    # ビュー: app/views/training_proposals/history.html.erb
  end
end
