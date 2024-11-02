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

  def edit
    @training_log = TrainingLog.find(params[:id])
  end

  def destroy
    @training_log = TrainingLog.find_by(id: params[:id])
    if @training_log
      @training_log.destroy
      redirect_to training_logs_path, notice: 'トレーニング記録が削除されました'
    else
      redirect_to training_logs_path, alert: '記録が見つかりませんでした'
    end
  end

  def update
    @training_log = TrainingLog.find(params[:id])
    if @training_log.update(training_log_params)
      redirect_to training_logs_path, notice: 'トレーニング記録が更新されました'
    else
      render :edit
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
