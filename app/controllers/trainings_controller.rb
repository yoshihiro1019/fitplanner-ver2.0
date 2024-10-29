class TrainingLogsController < ApplicationController
  before_action :authenticate_user!

  def index
    @training_logs = current_user&.training_logs || []
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
