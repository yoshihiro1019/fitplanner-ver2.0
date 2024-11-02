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
  
    suggestion = suggestions[part_name]
  
    flash[:suggestion] = suggestion
    redirect_to training_suggestions_path(body_part_id: selected_part) # 選択した部位をパラメータとして保持
  end

  def index
    # `@suggestion`は`flash`で表示されるため、ここでは特に変数を渡す必要はありません
  end

  private

  def set_body_parts
    @body_parts = BodyPart.all  # 部位の選択肢を取得
  end
end
