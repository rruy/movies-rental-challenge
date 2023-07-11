class RecommendationsController < ApplicationController
  def recommend
    favorite_movies = User.find_by(id: params[:user_id]).favorites
    @recommendations = RecommendationEngine.new(favorite_movies).recommendations

    render json: @recommendations
  end

  def available_genre

  end

  def recommend_by(preferred_genre, min_rating)
    preferred_genre = 'Action' if min_rating.nil?
    min_rating = 8.0 if min_rating.nil?

    recommended_movies = recommend_movies(preferred_genre, min_rating)

    render json: recommended_movies
  end
end
