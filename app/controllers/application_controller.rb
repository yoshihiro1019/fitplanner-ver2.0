class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  protect_from_forgery with: :exception

  # Deviseのヘルパーをビューで利用できるようにする
  helper_method :user_signed_in?, :current_user

  # ログインが必要な場合に使用
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) || super
  end

  # ログイン後のリダイレクト先を設定
 

  # ログアウト後のリダイレクト先を設定
  def after_sign_out_path_for(resource_or_scope)
    root_path  # ホームにリダイレクト
  end
end
