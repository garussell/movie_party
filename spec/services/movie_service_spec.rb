# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MovieService, :vcr do
  describe 'instance methods' do
    describe '.search_movies' do
      it 'generates search data' do
        search = MovieService.new.search_movies('Harry Potter')
        expect(search).to be_a(Hash)
        expect(search[:results]).to be_an(Array)
        search_data = search[:results].first

        expect(search_data).to have_key :title
        expect(search_data[:title]).to be_a(String)

        expect(search_data).to have_key :overview
        expect(search_data[:overview]).to be_a(String)

        expect(search_data).to have_key :vote_average
        expect(search_data[:vote_average]).to be_a(Float)

        expect(search_data).to have_key :vote_count
        expect(search_data[:vote_count]).to be_a(Integer)

        expect(search_data).to have_key :id
        expect(search_data[:id]).to be_a(Integer)
      end
    end

    describe '.discover_movies' do
      it 'generates top 20 movies' do
        search = MovieService.new.discover_movies
        expect(search).to be_a(Hash)
        expect(search[:results]).to be_an(Array)
        search_data = search[:results].first

        expect(search_data).to have_key :title
        expect(search_data[:title]).to be_a(String)

        expect(search_data).to have_key :overview
        expect(search_data[:overview]).to be_a(String)

        expect(search_data).to have_key :vote_average
        # expect(search_data[:vote_average]).to be_a(Float)

        expect(search_data).to have_key :vote_count
        expect(search_data[:vote_count]).to be_a(Integer)

        expect(search_data).to have_key :id
        expect(search_data[:id]).to be_a(Integer)
      end
    end

    describe '.credits' do
      it 'lists cast and crew' do
        search = MovieService.new.credits(667_538)
        expect(search).to be_a(Hash)
        expect(search[:cast]).to be_an(Array)
        search_data = search[:cast].first

        expect(search_data).to have_key :name
        expect(search_data[:name]).to be_a(String)

        expect(search_data).to have_key :character
        expect(search_data[:character]).to be_a(String)
      end
    end

    describe '.get_runtime' do
      it 'gets the movie runtime' do
        search = MovieService.new.get_runtime(667_538)
        expect(search).to be_a(Hash)
        expect(search[:runtime]).to be_an(Integer)
      end
    end

    describe '.reviews' do
      it 'it gets movie reviews' do
        search = MovieService.new.reviews(667_538)
        expect(search).to be_a(Hash)
        expect(search[:results]).to be_an(Array)
        search_data = search[:results].first

        expect(search_data).to have_key :author
        expect(search_data[:author]).to be_a(String)

        expect(search_data).to have_key :content
        expect(search_data[:content]).to be_a(String)
      end
    end

    describe '.genre_hash' do
      it 'provides key value pairs for genre_id and genre word' do
        search = MovieService.new.genre_hash
        expect(search).to be_a(Hash)
        expect(search[:genres]).to be_an(Array)
        search_data = search[:genres].first

        expect(search_data).to have_key :id
        expect(search_data[:id]).to be_an(Integer)

        expect(search_data).to have_key :name
        expect(search_data[:name]).to be_a(String)
      end
    end
  end
end
