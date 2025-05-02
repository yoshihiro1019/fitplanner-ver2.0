class SessionsController < ApplicationController
    def google_auth
      user = User.from_omniauth(request.env["omniauth.auth"])
      session[:user_id] = user.id
      redirect_to root_path, notice: t("sessions.google_auth.success")
    end

    def destroy
      session[:user_id] = nil
      redirect_to root_path, notice: t("sessions.destroy.success")
    end
end
