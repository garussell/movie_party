# frozen_string_literal: true

class WatchPartiesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @watch_party = @user.watch_parties.new
    facade = MovieFacade.new(params[:id])
    @movie = facade.get_movie_by_id(params[:id])
  end

  def create
    user_id = params[:user_id]
    movie_runtime = params[:runtime].to_i
    movie_title = params[:movie_title]
    user_ids = params[:watch_party][:user_ids]
    invited_users = User.where(id: user_ids)
    movie_id = params[:movie_id].to_i

    watch_party_params = {
      host: user_id,
      movie: movie_title,
      duration: params[:watch_party][:duration_minutes],
      time: params[:watch_party][:start_time],
      date: params[:watch_party][:date],
      users: invited_users
    }

    if params[:watch_party][:duration_minutes].to_i >= movie_runtime
      watch_party = WatchParty.create!(watch_party_params)

      UsersWatchParty.create!(user_id:, watch_party_id: watch_party.id)
      attendees = invited_users.each do |user|
        UsersWatchParty.create!(user_id: user.id, watch_party_id: watch_party.id)
      end
  
      redirect_to user_path(user_id, movie_id: movie_id, watch_party_params: watch_party_params,attendees: attendees)
    else
      flash[:error] = "Duration cannot be less than runtime - #{movie_runtime} minutes"
      redirect_back(fallback_location: root_path)
    end
  end
end
