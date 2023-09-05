# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movie do
  before do
    attrs = {
      id: 2,
      title: 'Batman',
      vote_average: 7,
      runtime: 90,
      genre: %w[Action Crime],
      overview: 'A rich guy with a dark private life',
      top_10: %w[bob fred jill tim nancy arron dolly nick bill sue],
      total_reviews: 100,
      review_authors: 'trollsalot'
    }

    @movie = Movie.new(attrs)
  end

  describe 'initialize' do
    it 'exists' do
      expect(@movie.id).to eq(2)
      expect(@movie).to be_a(Movie)
      expect(@movie.title).to eq('Batman')
      expect(@movie.vote_average).to eq(7)
      expect(@movie.runtime).to eq(90)
      expect(@movie.genre).to eq(%w[Action Crime])
      expect(@movie.overview).to eq('A rich guy with a dark private life')
      expect(@movie.top_10).to eq(%w[bob fred jill tim nancy arron dolly nick bill
                                              sue])
      expect(@movie.total_reviews).to eq(100)
      expect(@movie.review_authors).to eq('trollsalot')
    end
  end

  describe '.instance_methods' do
    describe 'format_runtime' do
      it "can format runtime to match '1h 30min'" do
        
        expect(@movie.format_runtime).to eq('1h 30min')
      end
    end

    describe 'format_genre' do
      it 'can list genre with humanized format' do
        @movie.genre
        expect(@movie.format_genre).to eq('Action, Crime')
      end
    end
  end
end
