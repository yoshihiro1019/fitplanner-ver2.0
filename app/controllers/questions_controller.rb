class QuestionsController < ApplicationController
  def index
    # 初期状態のフォームを表示
  end

  def create
    age = params[:age]
    experience = params[:experience]
    focus_area = params[:focus_area]
    
    # 入力項目が正しいか確認
    if age.present? && experience.present? && focus_area.present?
      suggestion = fetch_openai_response(age, experience, focus_area)
      flash[:suggestion] = suggestion || "提案が生成されませんでした。再度お試しください"
    else
      flash[:error] = "全ての項目を入力してください"
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
