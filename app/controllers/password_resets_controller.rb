class PasswordResetsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user
      # 新しいパスワードをランダムに生成して設定
      new_password = SecureRandom.alphanumeric(8)  # 8文字のランダムなパスワード
      @user.password = new_password
      @user.password_confirmation = new_password
      if @user.save
        flash[:notice] = "新しいパスワードは #{new_password} です。次回ログイン時に使用してください。"
        redirect_to root_path
      else
        flash[:alert] = "パスワードのリセットに失敗しました。"
        render :new
      end
    else
      flash[:alert] = "メールアドレスが見つかりません。"
      render :new
    end
  end
end
