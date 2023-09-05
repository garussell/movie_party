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
    @genre          = attributes[:genre]
    @overview       = attributes[:overview]
    @top_10         = attributes[:top_10]
    @total_reviews  = attributes[:total_reviews]
    @review_authors = attributes[:review_authors]
  end

  def format_runtime
    hours = @runtime / 60
    rest = @runtime % 60
    "#{hours}h #{rest}min"
  end

  def format_genre
    @genre.join(', ')
  end
end
