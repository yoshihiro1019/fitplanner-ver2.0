class QuestionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @training_suggestions = current_user.training_suggestions.order(created_at: :desc)
  end

  def create
      logger.debug "📦 home_equipment パラメータ: #{params[:home_equipment].inspect}"
    age               = params[:age]
    experience        = params[:experience]
    focus_area        = params[:focus_area]
    training_location = params[:training_location]
    home_equipment    = params[:home_equipment]

    if age.present? && experience.present? && focus_area.present?
      suggestion_text = fetch_openai_response(age, experience, focus_area, training_location, home_equipment)

      if suggestion_text.present?
        @training_suggestion = TrainingSuggestion.new(
          user: current_user,
          age: age,
          experience: experience,
          training_location: training_location,
          home_equipment: home_equipment,
          focus_area: focus_area,
          content: suggestion_text
        )

        if @training_suggestion.save
          flash[:notice] = t("flash.training_suggestion.saved", content: @training_suggestion.content)
        else
          flash[:alert] = t("flash.training_suggestion.save_failed")
        end
      else
        flash[:alert] = t("flash.training_suggestion.no_content")
      end
    else
      flash[:alert] = t("flash.training_suggestion.missing_input")
    end
    redirect_to questions_path
  end

  private

  def fetch_openai_response(age, experience, focus_area, training_location, home_equipment)
    client = OpenAI::Client.new

    system_prompt = I18n.t("prompts.training_suggestion.system")

    prompt = I18n.t(
      "prompts.training_suggestion.template",
      age: age,
      experience: experience,
      focus_area: focus_area,
      training_location: training_location,
      home_equipment: home_equipment
    )

    Rails.logger.info "=== system_prompt ==="
    Rails.logger.info system_prompt

    Rails.logger.info "=== user_prompt ==="
    Rails.logger.info prompt

    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [
          { role: "system", content: system_prompt },
          { role: "user", content: prompt }
        ]
      }
    )
    response.dig("choices", 0, "message", "content")
  end
end
