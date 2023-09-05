# frozen_string_literal: true

class MoviesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @facade = MovieFacade.new(params[:title])
  end
  
  def show
    @user = User.find(params[:user_id])
    @facade = MovieFacade.new(params[:id])
    @movie = @facade.get_movie_by_id(params[:id])
  end
end
