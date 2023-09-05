# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users' do
  before do
    @user_1 = User.create!(name: 'Ringo', email: 'ringo@gmail.com')

    @attendees = [bob = User.create!(name: 'Bob Ross', email: 'painter@gmail.com'),
                 rick = User.create!(name: 'Rick Ross', email: 'music@gmail.com')]
    @movie = {
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
      total_reviews: 7.0,
      review_authors: 'John Chard',
      user_id: @user_1.id
    }

    movie_facade_instance = MovieFacade.new('Batman')
    allow(movie_facade_instance).to receive(:get_search_movies).and_return(@movie)
    allow(MovieFacade).to receive(:new).and_return(movie_facade_instance)        
    
    @watch_party = @user_1.watch_parties.create!(
      host: @user_1.name, 
      movie: @movie[:title], 
      duration: @movie[:runtime], 
      time: @movie[:time], 
      date: @movie[:watch_data], 
      user_ids: [bob.id, rick.id]
      )

    visit user_path(@user_1)
  end

  describe 'dashboard' do
    it 'has user name' do
      expect(page).to have_content("Ringo's Dashboard")
    end

    it 'has button to Discover Movies page' do
      expect(page).to have_button('Discover Movies')

      click_on 'Discover Movies'

      expect(page).to have_current_path(user_discover_index_path(@user_1))
    end

    it 'lists watch parties' do
      expect(page).to have_content(@watch_party.host)
      expect(page).to have_content(@watch_party[:date])
      expect(page).to have_content(@watch_party[:time])
    end
  end
end
