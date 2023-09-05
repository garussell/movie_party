# frozen_string_literal: true

class RegistrationsController < ApplicationController
  def index
  end
  
  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    user.name = user.name.downcase
  
    session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"
      
    redirect_to welcome_index_path
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
