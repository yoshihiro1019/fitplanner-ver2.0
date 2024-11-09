class User < ApplicationRecord
  # Deviseのモジュール
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  # ユーザーが複数のトレーニング記録を持つ
  has_many :training_logs, dependent: :destroy

  # OmniAuthからの認証情報を元にユーザーを検索または作成
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.email = auth.info.email
      user.name = auth.info.name
      user.password = Devise.friendly_token[0, 20] # ランダムなパスワードを生成
      user.save!
    end
  end
end
