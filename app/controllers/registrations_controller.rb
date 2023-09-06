# frozen_string_literal: true

class RegistrationsController < ApplicationController
  def index; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome, #{@user.name}!"
      redirect_to registrations_path
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      redirect_to new_registration_path
    end
  end

  def login_form; end

  def login
    @user = User.find_by(email: params[:email])
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:success] = "Welcome, #{@user.name}!"
      if @user.admin?
        redirect_to admin_dashboard_path
      else
        redirect_to welcome_index_path
      end
    else
      flash[:error] = 'Wrong email or password.'
      render :login_form
    end
  end

  def logout
    session.delete(:user_id)
    flash[:notice] = 'Logged out successfully.'
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
