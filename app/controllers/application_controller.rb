class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :user_signed_in?, :current_user

  def current_user
    super || User.find_by(id: session[:user_id])  
  end



  def after_sign_in_path_for(resource)
    root_path  
  end


  def after_sign_out_path_for(resource_or_scope)
    root_path 
  end
end
