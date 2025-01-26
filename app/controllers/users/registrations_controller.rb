class Users::RegistrationsController < Devise::RegistrationsController
  protected

  def update_resource(resource, params)
    # current_password を除外して更新（現在のパスワード不要）
    resource.update_without_password(params.except(:current_password))
  end
end
