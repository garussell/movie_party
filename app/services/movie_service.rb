# frozen_string_literal: true

class MovieService
  def search_movies(title)
    get_url("/3/search/movie?language=en-US&page=1&query=#{title}")
  end

  def discover_movies
    get_url('/3/discover/movie?language=en-US&page=1&sort_by=popularity.desc&append_to_response=credits')
  end

  def movie_by_id(movie_id)
    get_url("/3/movie/#{movie_id}?language=en-US")
  end

  def credits(movie_id)
    get_url("/3/movie/#{movie_id}/credits?language=en-US")
  end

  def get_runtime(movie_id)
    get_url("/3/movie/#{movie_id}?append_to_response=runtime&language=en-US")
  end

  def reviews(movie_id)
    get_url("/3/movie/#{movie_id}/reviews?language=en-US&page=1")
  end

  def genre_hash
    get_url('/3/genre/movie/list?language=en')
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://api.themoviedb.org') do |f|
      f.params['api_key'] = ENV['API_KEY_AUTH']
    end
  end
end
