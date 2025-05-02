class TrainingLogsController < ApplicationController
  before_action :authenticate_user!  # ユーザーがログインしていることを確認

  def index
    if user_signed_in?
      @grouped_training_logs = current_user.training_logs.group_by(&:day_of_week)
    else
      @grouped_training_logs = {}
    end
  end

  def edit
    @training_log = TrainingLog.find(params[:id])
  end

  def destroy
    @training_log = TrainingLog.find_by(id: params[:id])
    if @training_log
      @training_log.destroy
      redirect_to training_logs_path, notice: t("training_logs.destroy.success")
    else
      redirect_to training_logs_path, alert: t("training_logs.destroy.not_found")
    end
  end

  def update
    @training_log = TrainingLog.find(params[:id])
    if @training_log.update(training_log_params)
      redirect_to training_logs_path, notice: t("training_logs.update.success")
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
      redirect_to training_logs_path(@training_log), notice: t("training_logs.create.success")
    else
      flash.now[:alert] = t("training_logs.create.failure")
      render :new
    end
  end

  private

  def training_log_params
    params.require(:training_log).permit(:training_type, :weight, :reps, :sets, :day_of_week)
  end
end
