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
        { name: 'ダンベルフライ', description: 'ベンチに仰向けになり、両手にダンベルを持ちます。胸の筋肉を伸ばしながらダンベルを広げ、ゆっくりと元の位置に戻します。' },
        { name: 'ベンチプレス', description: 'ベンチに仰向けになり、バーベルを持ち上げて胸の上で押し上げます。胸の筋肉を強化する基本的なエクササイズです。' },
        # 他の胸のエクササイズを追加
      ],
      'back' => [
        { name: '懸垂', description: '肩幅よりやや広めにバーを握り、肩甲骨を寄せるように体を持ち上げます。背中の筋肉を効果的に鍛えるエクササイズです。' },
        { name: 'デッドリフト', description: 'バーベルを床から持ち上げ、背中と脚の筋肉を強化します。正しいフォームで行うことが重要です。' },
        # 他の背中のエクササイズを追加
      ],
      'legs' => [
        { name: 'スクワット', description: 'バーベルを肩に担ぎ、膝を曲げて腰を下ろし、再び立ち上がります。脚と臀部の筋肉を鍛えます。' },
        { name: 'レッグプレス', description: 'レッグプレスマシンを使用して、脚の筋肉を押し出します。安全に行えるエクササイズです。' },
        # 他の脚のエクササイズを追加
      ],
      'arms' => [
        { name: 'バイセプスカール', description: 'ダンベルやバーベルを使用して、腕の前面（バイセプス）を鍛えます。' },
        { name: 'トライセプスエクステンション', description: 'ダンベルを頭の後ろに持ち上げ、腕の後面（トライセプス）を鍛えます。' },
        # 他の腕のエクササイズを追加
      ],
      'shoulders' => [
        { name: 'ショルダープレス', description: 'ダンベルやバーベルを頭上に押し上げ、肩の筋肉を鍛えます。' },
        { name: 'ラテラルレイズ', description: 'ダンベルを横に持ち上げ、肩の側面を強化します。' },
        # 他の肩のエクササイズを追加
      ],
      # 他の部位（例: 'abs', 'cardio' など）を追加
    }
  end
end
