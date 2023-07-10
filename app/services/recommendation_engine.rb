class RecommendationEngine
  def initialize(favorite_movies)
    @favorite_movies = favorite_movies
  end

  def recommendations
    movie_titles = get_movie_titles
    common_genres = get_common_genres(movie_titles)
    Movie.where(genre: common_genres).order(rating: :desc).limit(10)
  end

  private

  def get_movie_titles
    @favorite_movies.map(&:title)
  end

  def get_common_genres(movie_titles)
    genres = Movie.where(title: movie_titles).pluck(:genre)
    genres.group_by(&:itself).transform_values(&:size).sort_by { |_k, v| -v }.map(&:first).take(3)
  end
end
