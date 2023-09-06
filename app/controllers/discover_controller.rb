# frozen_string_literal: true

class DiscoverController < ApplicationController
  before_action :require_login

  def index
    @user = User.find(params[:user_id])
  end

  private

  def require_login
    return unless inactive_session?

    flash[:error] = 'You need to log in or register to discover movies'
    redirect_to login_path
  end
end
