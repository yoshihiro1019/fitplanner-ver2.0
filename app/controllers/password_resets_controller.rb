class PasswordResetsController < ApplicationController
  def new
  end

  def edit_direct
    @user = User.find_by(reset_password_token: params[:token])
  
    if @user.nil?
      flash[:alert] = "無効なトークンです。"
      redirect_to root_path
    end
  end

  def update_direct
    @user = current_user
    if @user.update(password_params)
      flash[:notice] = "パスワードが更新されました"
      redirect_to root_path
    else
      render :edit_direct
    end
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

  private

  # Strong Parametersの設定
  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
