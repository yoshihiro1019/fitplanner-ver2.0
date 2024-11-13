class TrainingSuggestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_body_parts, only: [:new, :create]

  def new
    # `@body_parts`は`set_body_parts`で取得済み
  end

  def create
    selected_part = params[:body_part_id]
    part_name = BodyPart.find(selected_part).name
  
    suggestions = {
      '胸' => 'ベンチプレスを行いましょう！',
      '背中' => '懸垂をやってみましょう！',
      '脚' => 'スクワットを追加しましょう！',
      '肩' => 'ショルダープレスで肩を鍛えましょう！',
      '腕' => 'ダンベルカールで腕を強化しましょう！'
    }
  
    @suggestion = suggestions[part_name]
  
    # リダイレクトして `@suggestion`をパラメータで渡す
    redirect_to training_suggestions_path(body_part_id: selected_part, suggestion: @suggestion)
  end

  def index
    # 部位選択画面で`@suggestion`がない場合は何も表示しない
  end

  private

  def set_body_parts
    @body_parts = BodyPart.all  # 部位の選択肢を取得
  end
end
