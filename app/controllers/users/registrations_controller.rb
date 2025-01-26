class Users::RegistrationsController < Devise::RegistrationsController
  
  protected
  
  # Deviseのコールバックで呼ばれるメソッド
  def update_resource(resource, params)
    # current_password を削除してから update_without_password に渡す
    resource.update_without_password(params.except(:current_password))
  end
end
