class TrainingSuggestionsController < ApplicationController
    before_action :authenticate_user!
  
    def new
      @body_parts = BodyPart.all  # 部位の選択肢を取得
    end
  
    def create
      selected_part = params[:body_part_id]
      part_name = BodyPart.find(selected_part).name
  
      # 部位ごとの提案内容を決定
      suggestions = {
        '胸' => 'ベンチプレスを行いましょう！',
        '背中' => '懸垂をやってみましょう！',
        '脚' => 'スクワットを追加しましょう！',
        '肩' => 'ショルダープレスで肩を鍛えましょう！',
        '腕' => 'ダンベルカールで腕を強化しましょう！'
      }
  
      suggestion = suggestions[part_name]
  
      # 提案結果を表示する
      redirect_to training_suggestions_path(suggestion: suggestion)
    end
  
    def index
      @suggestion = params[:suggestion]  # 提案結果を表示
    end
  end
  