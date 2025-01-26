class PasswordResetsController < ApplicationController

  def new
    # パスワードリセット申請フォームを表示するだけ
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user
      # トークンを生成してDBに保存
      @user.reset_password_token = SecureRandom.hex(10)
      @user.reset_password_sent_at = Time.current
      @user.save

      # メール送信
      UserMailer.password_reset(@user).deliver_now

      flash[:notice] = "パスワードリセットのメールを送信しました。"
      redirect_to root_path
    else
      flash[:alert] = "メールアドレスが見つかりません。"
      render :new
    end
  end

  def edit
    # ここでは params[:id] をトークンとして扱う
    @user = User.find_by(reset_password_token: params[:id])

    # トークンが無効 or 2時間以上経過なら弾く
    if @user.nil? || @user.reset_password_sent_at < 2.hours.ago
      flash[:alert] = "無効なトークンです。"
      redirect_to root_path
    end
  end

  def update
    @user = User.find_by(reset_password_token: params[:id])
    if @user.nil?
      flash[:alert] = "無効なトークンです。"
      redirect_to root_path
    elsif @user.update(password_params)
      # パスワード更新成功 → トークンを無効化
      @user.update(reset_password_token: nil)
      flash[:notice] = "パスワードが更新されました"
      redirect_to root_path
    else
      # バリデーションエラーなどがあれば再表示
      render :edit
    end
  end

 

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

end
