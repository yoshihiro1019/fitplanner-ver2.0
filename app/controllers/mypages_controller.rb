# app/controllers/mypages_controller.rb
class MypagesController < ApplicationController
  before_action :authenticate_user!

  def show
    flash.clear
    @user = current_user
  end
end
