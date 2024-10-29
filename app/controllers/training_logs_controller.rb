class TrainingLogsController < ApplicationController
  before_action :authenticate_user!  # ユーザーがログインしていることを確認

  def index
    # ログインしていないユーザーに対する処理
    if user_signed_in?
      @training_logs = current_user.training_logs
    else
      @training_logs = []  # ログインしていない場合は空の配列を返す
    end
  end

  def new
    @training_log = TrainingLog.new
  end

  def create
    @training_log = current_user.training_logs.build(training_log_params)
    if @training_log.save
      redirect_to training_logs_path, notice: 'トレーニング記録を保存しました！'
    else
      render :new, alert: '入力に誤りがあります。'
    end
  end

  private

  def training_log_params
    params.require(:training_log).permit(:training_type, :weight, :reps, :sets)
  end
end
