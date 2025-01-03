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
        { name: 'ダンベルフライ', description: 'ベンチに仰向けになり、両手にダンベルを持ちます。胸の筋肉を伸ばしながらダンベルを広げ、ゆっくりと元の位置に戻します。' ,youtube_url: 'https://www.youtube.com/embed/ls-cMaddd-4' 
        },
        { name: 'ベンチプレス', description: 'ベンチに仰向けになり、バーベルを持ち上げて胸の上で押し上げます。胸の筋肉を強化する基本的なエクササイズです。' ,youtube_url: 'https://www.youtube.com/embed/K6FQrDhTtXw'},
        # 他の胸のエクササイズを追加
      ],
      'back' => [
        { name: '懸垂', description: '肩幅よりやや広めにバーを握り、肩甲骨を寄せるように体を持ち上げます。背中の筋肉を効果的に鍛えるエクササイズです。' ,youtube_url: 'https://www.youtube.com/embed/EhQeBHP7rjE'  },
        { name: 'デッドリフト', description: 'バーベルを床から持ち上げ、背中と脚の筋肉を強化します。正しいフォームで行うことが重要です。' ,youtube_url: 'https://www.youtube.com/embed/XT8SxKi1QcI'},
        # 他の背中のエクササイズを追加
      ],
      'legs' => [
        { name: 'スクワット', description: 'バーベルを肩に担ぎ、膝を曲げて腰を下ろし、再び立ち上がります。脚と臀部の筋肉を鍛えます。' ,youtube_url: 'https://www.youtube.com/embed/v585xCrfn20'},
        { name: 'レッグプレス', description: 'レッグプレスマシンを使用して、脚の筋肉を押し出します。安全に行えるエクササイズです。' ,youtube_url: 'https://www.youtube.com/embed/mcdJRrMCAhw'},
        # 他の脚のエクササイズを追加
      ],
      'arms' => [
        { name: 'ダンベルカール', description: 'ダンベルや使用して、上腕二頭筋を鍛えます。' ,youtube_url: 'https://www.youtube.com/embed/ZMtbcmkFz1w'},
        { name: 'ケーブルエクステンション', description: 'ケーブルマシンを使用して、腕の後面（トライセプス）を鍛えます。' ,youtube_url: 'https://www.youtube.com/embed/NAry9DhipJA'},
        # 他の腕のエクササイズを追加
      ],
      'shoulders' => [
        { name: 'ショルダープレス', description: 'ダンベルやバーベルを頭上に押し上げ、肩の筋肉を鍛えます。' ,youtube_url: 'https://www.youtube.com/embed/IH24_ohO4Jc'},
        { name: 'サイドレイズ', description: 'ダンベルを横に持ち上げ、肩の側面を強化します。' ,youtube_url: 'https://www.youtube.com/embed/-bvP-lzw6X0'},
        # 他の肩のエクササイズを追加
      ],
      # 他の部位（例: 'abs', 'cardio' など）を追加
    }
  end
end
