class Users::PasswordsController < Devise::PasswordsController
    # パスワード変更用の新しいアクション
    def edit_direct
      @user = current_user
    end

    # トークンなしでパスワードを直接更新
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
