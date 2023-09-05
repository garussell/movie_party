# frozen_string_literal: true

class Movie
  attr_reader :id,
              :title,
              :vote_average,
              :runtime,
              :genre,
              :overview,
              :top_10,
              :total_reviews,
              :review_authors

  def initialize(attributes)
    @id             = attributes[:id]
    @title          = attributes[:title]
    @vote_average   = attributes[:vote_average]
    @runtime        = attributes[:runtime]
    @genre          = get_genre_names(attributes[:genre_ids])
    @overview       = attributes[:overview]
    @top_10         = get_movie_cast(attributes[:id])
    @review_authors = get_movie_review_authors_and_content(attributes[:id])
    @total_reviews  = @review_authors&.count
  end

  def movie
    MovieService.new
  end

  def format_runtime
    hours = @runtime / 60
    rest = @runtime % 60
    "#{hours}h #{rest}min"
  end

  def format_genre
    @genre.join(', ')
  end

  def get_genre_names(genre_ids)
    genre_names = []
    genre_ids&.each do |genre_id|
      genre = movie.genre_hash[:genres].find { |genre| genre[:id] == genre_id }
      genre_names << genre[:name] if genre
    end

    genre_names
  end

  def get_movie_cast(movie_id)
    cast_and_char = []
    credits = movie.credits(movie_id)

    credits[:cast]&.each do |cast_member|
      key = cast_member[:name]
      value = cast_member[:character]
      cast_and_char << { key => value }
    end

    cast_and_char[0..9]
  end

  def get_movie_review_authors_and_content(movie_id)
    author_and_content = []
    reviews = movie.reviews(movie_id)

    reviews[:results]&.each do |review|
      key = review[:author]
      value = review[:content]
      author_and_content << { key => value }
    end
  end
end
