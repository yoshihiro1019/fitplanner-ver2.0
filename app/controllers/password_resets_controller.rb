class PasswordResetsController < ApplicationController
  def new
  end

  def edit_direct
    @user = User.find_by(reset_password_token: params[:token])

    if @user.nil?
      flash[:alert] = t('password_resets.edit_direct.invalid_token')
      redirect_to root_path
    end
  end

  def update_direct
    @user = current_user
    if @user.update(password_params)
      flash[:notice] = t('password_resets.update_direct.success')
      redirect_to root_path
    else
      render :edit_direct
    end
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user
      new_password = SecureRandom.alphanumeric(8)
      @user.password = new_password
      @user.password_confirmation = new_password
      if @user.save
        flash[:notice] = t('password_resets.create.success', new_password: new_password)
        redirect_to root_path
      else
        flash[:alert] = t('password_resets.create.failure')
        render :new
      end
    else
      flash[:alert] = t('password_resets.create.email_not_found')
      render :new
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
