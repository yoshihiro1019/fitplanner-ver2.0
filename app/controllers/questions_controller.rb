class QuestionsController < ApplicationController
  def index
    # 履歴として表示するデータは「自分のレコードだけ」に限定
    @training_suggestions = current_user.training_suggestions.order(created_at: :desc)
  end


  def create
    age = params[:age]
    experience = params[:experience]
    focus_area = params[:focus_area]
    training_location = params[:training_location]
    home_equipment = params[:home_equipment]
  
    # 入力項目が正しいか確認
    if age.present? && experience.present? && focus_area.present?
      suggestion_text = fetch_openai_response(age, experience, focus_area, training_location, home_equipment)
  
      if suggestion_text.present?
        # 提案をデータベースに保存
        training_suggestion = TrainingSuggestion.new(
          user: current_user,
          age: age,
          experience: experience,
          training_location: training_location,
          home_equipment: home_equipment,
          focus_area: focus_area,
          content: suggestion_text
        )
  
        if training_suggestion.save
          flash.now[:suggestion] = "提案を保存しました: #{training_suggestion.content}"
        else
          flash.now[:error] = "提案の保存に失敗しました。"
        end
      else
        flash.now[:suggestion] = "提案が生成されませんでした。再度お試しください。"
      end
    else
      flash.now[:error] = "全ての項目を入力してください。"
    end
  
    respond_to do |format|
      format.html { render :index } # redirect_to を render に変更
      format.turbo_stream { render turbo_stream: turbo_stream.replace("flash_messages", partial: "shared/flash_messages") }
    end
  end

  private

  def fetch_openai_response(age, experience, focus_area, training_location, home_equipment)
    client = OpenAI::Client.new
  
  prompt = I18n.t(
  "prompts.training_suggestion.template",
  age: age,
  experience: experience,
  focus_area: focus_area,
  training_location: training_location,
  home_equipment: home_equipment
)

  
response = client.chat(
  parameters: {
    model: "gpt-3.5-turbo",
    messages: [
      { role: "system", content: "あなたはプロの日本語フィットネストレーナーです。常に日本語で提案をしてください。" },
      { role: "user", content: prompt }
    ]
  }
)
response.dig("choices", 0, "message", "content")
  end
  
end
