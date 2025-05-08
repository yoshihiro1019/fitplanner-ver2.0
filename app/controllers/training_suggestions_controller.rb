class TrainingSuggestionsController < ApplicationController
  before_action :authenticate_user! 
  before_action :set_suggestions, only: [ :create ]

  def new
    @body_parts = BodyPart.all
  end

  def create
    body_part_code = params[:body_part_code].to_s.strip.to_sym
    Rails.logger.debug "★DEBUG: body_part_code = #{body_part_code}"
  
    @suggestions = @all_suggestions[body_part_code]
    Rails.logger.debug "★DEBUG: available keys = #{@all_suggestions.keys}"
    Rails.logger.debug "★DEBUG: matched suggestions = #{@suggestions.inspect}"
  
    @body_part = BodyPart.find_by(code: body_part_code.to_s)
  
    respond_to do |format|
      if @suggestions.present?
        format.html { render :show }
        format.json { render json: { suggestions: @suggestions, status: :ok } }
      else
        format.html do
          flash[:alert] = t("training_suggestions.not_found")
          redirect_to new_training_suggestion_path
        end
        format.json { render json: { error: t("training_suggestions.not_found") }, status: :not_found }
      end
    end
  end
  
  def set_suggestions
    @all_suggestions = I18n.t("training_suggestions.presets")
  end
  
  
end
