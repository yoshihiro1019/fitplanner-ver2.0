# app/models/user.rb

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2, :spotify]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name # 必要に応じて name カラムを追加

      if auth.provider == 'spotify'
        user.spotify_id = auth.uid
        user.access_token = auth.credentials.token
        user.refresh_token = auth.credentials.refresh_token
        user.token_expires_at = Time.at(auth.credentials.expires_at)
      end
    end
  end

  has_many :training_logs, dependent: :destroy
  has_many :training_suggestions, dependent: :destroy 
  
  # Spotifyの認証情報を更新するメソッド
  def update_spotify_credentials(token_info)
    self.access_token = token_info['access_token']
    self.refresh_token = token_info['refresh_token'] if token_info['refresh_token']
    self.token_expires_at = Time.now + token_info['expires_in']
    save
  end

  # アクセストークンの有効期限をチェック
  def access_token_valid?
    self.token_expires_at > Time.now
  end

  # アクセストークンをリフレッシュするメソッド
  def refresh_spotify_token
    token_response = RestClient.post('https://accounts.spotify.com/api/token', {
      grant_type: 'refresh_token',
      refresh_token: self.refresh_token,
      client_id: ENV['SPOTIFY_CLIENT_ID'],
      client_secret: ENV['SPOTIFY_CLIENT_SECRET']
    })

    token_info = JSON.parse(token_response.body)
    self.access_token = token_info['access_token']
    self.token_expires_at = Time.now + token_info['expires_in']
    self.refresh_token = token_info['refresh_token'] if token_info['refresh_token']
    save
  rescue RestClient::ExceptionWithResponse => e
    Rails.logger.error "Spotifyトークンのリフレッシュに失敗しました: #{e.response}"
  end
end
