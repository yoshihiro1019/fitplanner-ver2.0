# app/controllers/mypages_controller.rb
class MypagesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end
end
