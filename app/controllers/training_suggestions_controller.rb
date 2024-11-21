class TrainingSuggestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_body_parts
  before_action :set_suggestions

  def new
    # 部位選択フォームを表示
  end

  def create
    selected_part = params[:body_part_id].to_i

    @suggestions = @all_suggestions[selected_part]

    if @suggestions.nil?
      flash[:alert] = "選択された部位の提案が見つかりません。"
      redirect_to new_training_suggestion_path
    else
      redirect_to training_suggestions_path(body_part_id: selected_part)
    end
  end

  def index
    if params[:body_part_id]
      selected_part = params[:body_part_id].to_i
      @suggestions = @all_suggestions[selected_part]
      @part_name = BodyPart.find(selected_part).name
    else
      flash[:alert] = "部位を選択してください。"
      redirect_to new_training_suggestion_path
    end
  end

  private

  def set_body_parts
    @body_parts = BodyPart.all
  end

  def set_suggestions
    @all_suggestions = {
      1 => [
        { 
          name: 'ダンベルフライ', 
          description: 'ベンチに仰向けになり、両手にダンベルを持ちます。腕を広げながらダンベルを胸の高さまでゆっくり下ろし、胸の筋肉を意識して戻します。' 
        },
        { 
          name: 'ベンチプレス', 
          description: 'ベンチに仰向けになり、バーベルを肩幅よりやや広めに握ります。胸の中央に下ろし、胸筋を意識して持ち上げます。' 
        },
        { 
          name: 'プッシュアップ', 
          description: '手を肩幅よりやや広めに床につけ、体を一直線に保ちながら胸を床に近づけます。その後、胸筋を意識して押し上げます。' 
        }
      ],
      2 => [
        { 
          name: '懸垂', 
          description: '肩幅よりやや広めにバーを握り、肩甲骨を寄せるように体を持ち上げます。ゆっくりと元に戻します。' 
        },
        { 
          name: 'ラットプルダウン', 
          description: '広いバーを肩幅より広く握り、胸に向かってバーを引き下ろします。その際、背中の筋肉を意識します。' 
        },
        { 
          name: 'デッドリフト', 
          description: 'バーベルを床から持ち上げる際、背中をまっすぐに保ちながら膝と腰を使って立ち上がります。元に戻る際も同じ姿勢を保ちます。' 
        }
      ],
      3 => [
        { 
          name: 'スクワット', 
          description: '足を肩幅に開き、つま先をわずかに外側に向けます。膝を曲げて腰を落とし、太ももが床と平行になるまで下ろします。膝を伸ばして元に戻ります。' 
        },
        { 
          name: 'レッグプレス', 
          description: 'レッグプレスマシンに座り、両足でプレートを押します。膝が直角になる位置まで下ろし、足で押して元に戻します。' 
        },
        { 
          name: 'ランジ', 
          description: '片足を大きく前に踏み出し、膝を90度に曲げながら腰を下ろします。後ろ足の膝が床に近づくまで下ろし、元に戻ります。左右交互に繰り返します。' 
        }
      ],
      4 => [
        { 
          name: 'バーベルカール', 
          description: 'バーベルを両手で握り、肘を固定して腕を曲げながらバーベルを持ち上げます。ゆっくりと元に戻します。' 
        },
        { 
          name: 'ダンベルカール', 
          description: 'ダンベルを両手に持ち、肘を固定して片腕ずつ持ち上げます。腕の動きをコントロールしながら戻します。' 
        },
        { 
          name: 'プリーチャーカール', 
          description: 'プリーチャーベンチに腕を乗せ、ダンベルを持ち上げます。上腕二頭筋を意識してゆっくり戻します。' 
        }
      ],
      5 => [
        { 
          name: 'ショルダープレス', 
          description: 'ダンベルを肩の高さに構え、腕を伸ばして真上に持ち上げます。肩の筋肉を意識してゆっくり下ろします。' 
        },
        { 
          name: 'サイドレイズ', 
          description: 'ダンベルを両手に持ち、腕を横に広げて肩の高さまで持ち上げます。ゆっくりと元に戻します。' 
        },
        { 
          name: 'フロントレイズ', 
          description: 'ダンベルを両手に持ち、腕を前方に伸ばして肩の高さまで持ち上げます。ゆっくり下ろします。' 
        }
      ]
    }
  end
  
end
