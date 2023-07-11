class RecommendationEngine
  def initialize(favorite_movies)
    @favorite_movies = favorite_movies
  end

  def recommend
    Movie.where(genre: common_genres).order(rating: :desc).limit(10)
  end

  # Method to recommend movies based on genre and rating
  def recommend_by(preferred_genre, min_rating)
    Movie.where(genre: preferred_genre).where('rating >= ?', min_rating).order(rating: :desc).limit(10)
  end

  def common_genres
    movie_titles = @favorite_movies.map(&:title)

    genres = Movie.where(title: movie_titles).pluck(:genre)
    genres.group_by(&:itself).transform_values(&:size).sort_by { |_k, v| -v }.map(&:first).take(3)
  end
end
