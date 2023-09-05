# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'new watch party page', :vcr do
  before do
    @user_1 = User.create!(name: 'Ringo', email: 'ringo@gmail.com')

    @movie_data = {
      id: 268,
      title: 'Batman',
      vote_average: 7.214,
      runtime: '2h 6min',
      genre: 'Fantasy, Fiction, Crime',
      overview: "Batman must face his most ruthless nemesis when a deformed madman calling himself 'The Joker' seizes control of Gotham's criminal underworld.",
      top_10: "Michael Keaton as Bruce Wayne / Batman
      Jack Nicholson as Jack Napier / The Joker
      Kim Basinger as Vicki Vale
      Michael Gough as Alfred Pennyworth
      Jerry Hall as Alicia Grissom
      Robert Wuhl as Alexander Knox
      Pat Hingle as Commissioner James Gordon
      Billy Dee Williams as Harvey Dent
      Jack Palance as Carl Grissom
      Tracey Walter as Bob the Goon",
      total_reviews: 7,
      review_authors: 'John Chard',
      user_id: @user_1.id
    }

    movie_facade_instance = MovieFacade.new('Batman')
    allow(movie_facade_instance).to receive(:get_search_movies).and_return(@movie_data)
    allow(MovieFacade).to receive(:new).and_return(movie_facade_instance)
    visit new_user_watch_party_path(@user_1, @movie_data[:id])
  end

  describe 'as a user' do
    describe 'when I visit the new watch party page' do
      it 'I can fill out a form to create a new watch party and the form includes movie title, duration, data, start_time, and check_boxes to invite other users' do
        expect(page).to have_content('Movie Title')
        expect(page).to have_content('Duration')
        expect(page).to have_content('When')
        expect(page).to have_content('Start time')
        expect(page).to have_content('Invite Other User')
      end
    end
  end
end
