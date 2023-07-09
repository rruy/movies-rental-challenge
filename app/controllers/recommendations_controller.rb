class RecommendationsController < ApplicationController
  def recommend
    favorite_movies = User.find_by(id: params[:user_id]).favorites
    @recommendations = RecommendationEngine.new(favorite_movies).recommendations

    render json: @recommendations
  end
end
