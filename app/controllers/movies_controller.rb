# frozen_string_literal: true

class MoviesController < ApplicationController
  before_action :require_login

  def index
    @user = User.find(params[:user_id])
    @facade = MovieFacade.new(params[:title])
  end

  def show
    @user = User.find(params[:user_id])
    @facade = MovieFacade.new(params[:id])
    @movie = @facade.get_movie_by_id(params[:id])
  end

  private

    def require_login
      if inactive_session?
        flash[:error] = "You need to log in or register to look at movies"
        redirect_to login_path
      end
    end
end
