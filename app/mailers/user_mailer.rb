class UserMailer < ApplicationMailer
  def password_reset(user)
    @user = user
    # edit_password_reset_url の引数は、デフォルトでは「id」とみなされるが
    # 実際にはトークンを入れるため、 user.reset_password_token を渡す
    @url  = edit_password_reset_url(@user.reset_password_token)

    mail(to: @user.email, subject: "パスワードリセット")
  end
end
