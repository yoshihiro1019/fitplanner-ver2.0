class Users::PasswordsController < Devise::PasswordsController
    def edit_direct
      @user = current_user
    end

    def update_direct
      @user = current_user
      if @user.update(password_params)
        bypass_sign_in(@user) # 再ログインを避けるためのバイパス
        redirect_to root_path, notice: "パスワードが更新されました"
      else
        render :edit_direct
      end
    end

    private

    def password_params
      params.require(:user).permit(:password, :password_confirmation)
    end
end
