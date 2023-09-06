# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :require_login

  def show
    @user = User.find(params[:id])
    @watch_party = params[:watch_party_params]

    if @watch_party && params[:watch_party_params][:user_ids]
      attendees = params[:watch_party_params][:user_ids].map { |id| id.to_i }
      @attendees = attendees.map { |attendee| User.find_by(id: attendee) }.compact
    end

    @facade = MovieFacade.new(params[:id])
    @movie = @facade.get_movie_by_id(params[:movie_id])
    @image = @facade.get_movie_image_by_id(params[:movie_id])
  end

  private

  def require_login
    if inactive_session?
      flash[:error] = "You need to log in or register"
      redirect_to login_path
    end
  end
end
