class TrainingLogsController < ApplicationController
  before_action :authenticate_user!  # ユーザーがログインしていることを確認
  before_action :set_training_log, only: [:edit, :update, :destroy] # 編集・更新・削除に必要なトレーニング記録を取得
  def index
    # ログインしていないユーザーに対する処理
    if user_signed_in?
      @training_logs = current_user.training_logs
    else
      @training_logs = []  # ログインしていない場合は空の配列を返す
    end
  end

  # app/controllers/training_logs_controller.rb
def show
  redirect_to training_logs_path, notice: 'トレーニング記録の一覧にリダイレクトされました。'
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

  def edit
  end

  # 更新処理
  def update
    if @training_log.update(training_log_params)
      redirect_to training_logs_path, notice: 'トレーニング記録を更新しました！'
    else
      render :edit, alert: '入力に誤りがあります。'
    end
  end

  # 削除処理
  def destroy
    @training_log.destroy
    redirect_to training_logs_path, notice: 'トレーニング記録を削除しました！'
  end


  private

  def set_training_log
    @training_log = current_user.training_logs.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to training_logs_path, alert: '指定されたトレーニング記録が見つかりません。'
  end

  def training_log_params
    params.require(:training_log).permit(:training_type, :weight, :reps, :sets)
  end
end
