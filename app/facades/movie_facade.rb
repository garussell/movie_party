# frozen_string_literal: true

class MovieFacade
  def initialize(title)
    @title = title
  end

  def movie
    MovieService.new
  end

  def get_discover_movies
    discover = movie.discover_movies

    discover[:results].map do |movie_data|
      build_movie_from_api(movie_data)
    end
  end

  def get_movie_image_by_id(movie_id)
    base_image_url = 'https://image.tmdb.org/t/p/original'.freeze

    image = movie.movie_by_id(movie_id)
    poster_path = image[:poster_path]

    full_image_url = "#{base_image_url}#{poster_path}"
    full_image_url
  end

  def discovery?
    @title.nil?
  end

  def get_search_movies
    json = movie.search_movies(@title)
    json[:results].map do |movie_data|
      build_movie_from_api(movie_data)
    end
  end

  def get_movie_by_id(movie_id)
    movie_data = movie.movie_by_id(movie_id)
    build_movie_from_api(movie_data)
  end

  private

  def build_movie_from_api(movie_data)
    Movie.new(movie_data)
  end
end
