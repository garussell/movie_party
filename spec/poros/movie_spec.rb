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
      top_10: [{ 'Turo Pajala' => 'Taisto Kasurinen' },
               { 'Susanna Haavisto' => 'Irmeli Pihlaja' },
               { 'Matti Pellonpää' => 'Mikkonen' },
               { 'Eetu Hilkamo' => 'Riku' },
               { 'Erkki Pajala' => 'Miner' },
               { 'Matti Jaaranen' => 'Mugger' },
               { 'Hannu Viholainen' => 'Accomplice' },
               { 'Jorma Markkula' => 'Tallyman' },
               { 'Tarja Keinänen' => 'Woman in Harbour' },
               { 'Eino Kuusela' => 'Man on Beach' }],
      total_reviews: 0,
      review_authors: []
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
      expect(@movie.genre).to eq([])
      expect(@movie.overview).to eq('A rich guy with a dark private life')
      expect(@movie.top_10.count).to eq(10)
      expect(@movie.total_reviews).to eq(0)
      expect(@movie.review_authors).to eq([])
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
        expect(@movie.format_genre).to eq('')
      end
    end
  end
end
