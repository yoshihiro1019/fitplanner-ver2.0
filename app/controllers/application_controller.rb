class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Deviseのヘルパーをビューで利用できるようにする
  helper_method :user_signed_in?, :current_user

  # ログインが必要な場合に使用
  def current_user
    super || User.find_by(id: session[:user_id])  # Devise でサインインしていない場合に手動で取得
  end

  # ログイン後のリダイレクト先を設定

  def after_sign_in_path_for(resource)
    root_path  # サインイン後のリダイレクト先
  end

  # ログアウト後のリダイレクト先を設定
  def after_sign_out_path_for(resource_or_scope)
    root_path  # ホームにリダイレクト
  end
end
