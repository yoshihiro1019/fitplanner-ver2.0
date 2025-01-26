class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # ★ここに追加するのがおすすめ
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Deviseのヘルパーをビューで利用できるようにする
  helper_method :user_signed_in?, :current_user

  # ログインが必要な場合に使用
  def current_user
    super || User.find_by(id: session[:user_id])  # Devise でサインインしていない場合に手動で取得
  end

  # ログイン後のリダイレクト先
  def after_sign_in_path_for(resource)
    root_path
  end

  # ログアウト後のリダイレクト先
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  protected  # ここより下はprotectedメソッド

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [
      :email,
      :password,
      :password_confirmation,
      :current_password
    ])
  end
end
