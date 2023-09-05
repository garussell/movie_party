# frozen_string_literal: true

class MovieFacade
  def initialize(title)
    @title = title
    @movie = MovieService.new
  end

  def get_discover_movies
    discover = @movie.discover_movies

    discover[:results].map do |movie_data|
      build_movie_from_api(movie_data)
    end
  end

  def get_movie_image_by_id(movie_id)
    base_image_url = 'https://image.tmdb.org/t/p/original'.freeze

    image = @movie.movie_by_id(movie_id)
    poster_path = image[:poster_path]

    full_image_url = "#{base_image_url}#{poster_path}"
    full_image_url
  end

  def discovery?
    @title.nil?
  end

  def get_search_movies
    json = @movie.search_movies(@title)
    json[:results].map do |movie_data|
      build_movie_from_single_search(movie_data)
    end
  end

  def get_movie_by_id(movie_id)
    movie_data = @movie.movie_by_id(movie_id)
    build_movie_from_single_search(movie_data)
  end

  private

  def build_movie_from_single_search(movie_data)
    movie_id = movie_data[:id]
    authors = get_movie_review_authors_and_content(movie_id)
    cast = get_movie_cast(movie_id)

    genre_names = movie_data[:genres]&.map { |genre| genre[:name] }

    attributes = {
      id: movie_data[:id],
      title: movie_data[:title],
      vote_average: movie_data[:vote_average],
      runtime: movie_data[:runtime],
      genre: genre_names,
      overview: movie_data[:overview],
      top_10: cast[0..9],
      total_reviews: authors&.count,
      review_authors: authors
    }

    Movie.new(attributes)
  end

  def build_movie_from_api(movie_data)
    genre_names = get_genre_names(movie_data[:genre_ids])
    movie_id = movie_data[:id]
    movie_runtime = get_movie_runtime(movie_id)
    cast = get_movie_cast(movie_id)
    authors = get_movie_review_authors_and_content(movie_id)

    attributes = {
      id: movie_data[:id],
      title: movie_data[:title],
      vote_average: movie_data[:vote_average],
      runtime: movie_runtime[:runtime],
      genre: genre_names,
      overview: movie_data[:overview],
      top_10: cast[0..9],
      total_reviews: authors.count,
      review_authors: authors
    }

    Movie.new(attributes)
  end

  def get_genre_names(genre_ids)
    genre_names = []
    genre_ids.each do |genre_id|
      genre = @movie.genre_hash[:genres].find { |genre| genre[:id] == genre_id }
      genre_names << genre[:name] if genre
    end

    genre_names
  end

  def get_movie_runtime(movie_id)
    @movie.get_runtime(movie_id)
  end

  def get_movie_cast(movie_id)
    cast_and_char = []
    credits = @movie.credits(movie_id)

    credits[:cast]&.each do |cast_member|
      key = cast_member[:name]
      value = cast_member[:character]
      cast_and_char << { key => value }
    end

    cast_and_char
  end

  def get_movie_review_authors_and_content(movie_id)
    author_and_content = []
    reviews = @movie.reviews(movie_id)

    reviews[:results]&.each do |review|
      key = review[:author]
      value = review[:content]
      author_and_content << { key => value }
    end
  end
end
