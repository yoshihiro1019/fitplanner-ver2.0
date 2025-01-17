class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    # OmniAuthから認証情報を取得
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      flash[:notice] = "Googleアカウントでログインしました。" if is_navigational_format?
    else
      session["devise.google_data"] = request.env["omniauth.auth"].except(:extra)
      redirect_to new_user_registration_url, alert: "Googleログインに失敗しました。"
    end
  end

  def spotify
    # OmniAuthから認証情報を取得
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      flash[:notice] = "Spotifyアカウントでログインしました。" if is_navigational_format?
    else
      session["devise.spotify_data"] = request.env["omniauth.auth"].except(:extra)
      redirect_to new_user_registration_url, alert: "Spotifyログインに失敗しました。"
    end
  end
end
