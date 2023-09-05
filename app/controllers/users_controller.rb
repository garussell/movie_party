# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @watch_party = params[:watch_party_params]

    @attendees = if params[:attendees].nil?
                   params[:attendees]&.map { |_attendee_id| User.find(id) }
                 else
                   User.find(params[:attendees])
                 end

    @facade = MovieFacade.new(params[:id])
    @movie = @facade.get_movie_by_id(params[:movie_id])
    @image = @facade.get_movie_image_by_id(params[:movie_id])
  end
end
