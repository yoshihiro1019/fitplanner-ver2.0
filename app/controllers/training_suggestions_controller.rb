class TrainingSuggestionsController < ApplicationController
  before_action :authenticate_user! # Deviseを使用している場合
  before_action :set_suggestions, only: [:create]

  def new
    @body_parts = BodyPart.all
  end

  def create
    body_part_code = params[:body_part_code]
    @suggestions = @all_suggestions[body_part_code]
    @body_part = BodyPart.find_by(code: body_part_code)

    # デバッグログの追加
    Rails.logger.debug "Body Part Code: #{body_part_code}"
    Rails.logger.debug "Body Part: #{@body_part.inspect}"
    Rails.logger.debug "Suggestions: #{@suggestions.inspect}"

    if @suggestions.present?
      render :show
    else
      flash[:alert] = "選択された部位の提案が見つかりません。"
      redirect_to new_training_suggestion_path
    end
  end

  # 不要な index アクションを削除またはコメントアウト
  # def index
  #   @training_suggestions = TrainingSuggestion.all
  # end

  private

  def set_suggestions
    @all_suggestions = {
      'chest' => [
        { name: 'ダンベルフライ', description: 'ベンチに仰向けになり、両手にダンベルを持ちます。...' },
        # 他の胸のエクササイズ
      ],
      'back' => [
        { name: '懸垂', description: '肩幅よりやや広めにバーを握り、肩甲骨を寄せるように体を持ち上げます。...' },
        # 他の背中のエクササイズ
      ],
      # 他の部位...
    }
  end
end
