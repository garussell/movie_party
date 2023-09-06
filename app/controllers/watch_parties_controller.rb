# frozen_string_literal: true

class WatchPartiesController < ApplicationController
  before_action :require_login

  def new
    @user = User.find(params[:user_id])
    @watch_party = @user.watch_parties.new
    facade = MovieFacade.new(params[:id])
    @movie = facade.get_movie_by_id(params[:id])
  end

  def create
    user_id = params[:user_id]
    movie_runtime = params[:runtime].to_i
    invited_users
    movie_id = params[:movie_id].to_i

    if params[:watch_party][:duration_minutes].to_i >= movie_runtime
      watch_party = WatchParty.new(watch_party_params)

      if watch_party.save(validate: false)
        redirect_to user_path(user_id, movie_id:, watch_party_params:)
      else
        flash[:error] = watch_party.errors.full_messages.to_sentence
        redirect_back(fallback_location: root_path)
      end
    else
      flash[:error] = "Duration cannot be less than runtime - #{movie_runtime} minutes"
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def require_login
    return unless inactive_session?

    flash[:error] = 'You need to log in or register to create a watch party'
    redirect_to login_path
  end

  def watch_party_params
    {
      host: params[:user_id],
      movie: params[:movie_title],
      duration: params[:watch_party][:duration_minutes],
      date: params[:watch_party][:date],
      time: params[:watch_party][:start_time],
      user_ids: invited_users
    }
  end

  def invited_users
    params[:watch_party][:user_ids].reject { |id| id == '0' }
  end
end
