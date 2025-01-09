class QuestionsController < ApplicationController
  def index
    # 初期状態のフォームを表示
    @training_suggestions = TrainingSuggestion.order(created_at: :desc)
  end

  def create
    age = params[:age]
    experience = params[:experience]
    focus_area = params[:focus_area]
    
    # 入力項目が正しいか確認
    if age.present? && experience.present? && focus_area.present?
      suggestion_text = fetch_openai_response(age, experience, focus_area)
      
      if suggestion_text.present?
        # 提案をデータベースに保存
        training_suggestion = TrainingSuggestion.new(
          user: current_user,           # ユーザーと紐付ける場合
          age: age,
          experience: experience,
          focus_area: focus_area,
          content: suggestion_text
        )
        
        if training_suggestion.save
          flash[:suggestion] = "提案を保存しました: #{training_suggestion.content}"
        else
          flash[:error] = "提案の保存に失敗しました。"
        end
      else
        flash[:suggestion] = "提案が生成されませんでした。再度お試しください。"
      end
    else
      flash[:error] = "全ての項目を入力してください。"
    end

    respond_to do |format|
      format.html { redirect_to questions_path }
      format.turbo_stream { render turbo_stream: turbo_stream.replace("flash_messages", partial: "shared/flash_messages") }
    end
  end

  private

  def fetch_openai_response(age, experience, focus_area)
    client = OpenAI::Client.new

    prompt = <<~PROMPT
      ユーザーの年齢: #{age}
      トレーニング経験: #{experience}
      重点を置きたい部位: #{focus_area}
    PROMPT

    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [{ role: "user", content: prompt }]
      }
    )

    response.dig("choices", 0, "message", "content")
  end
end
