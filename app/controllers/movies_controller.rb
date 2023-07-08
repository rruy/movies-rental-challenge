class MoviesController < ApplicationController
  before_action :load_user, :load_movie, only: [:rent]
  before_action :load_user, only: %i[rent recommendations user_rented_movies]

  def index
    @movies = Movie.all.page(params[:page]).per(10)

    render json: {
      movies: @movies,
      total_pages: @movies.total_pages,
      total_count: @movies.total_count,
      current_page: @movies.current_page
    }
  end

  def recommendations
    favorite_movies = @user.favorites
    @recommendations = RecommendationEngine.new(favorite_movies).recommendations
    render json: @recommendations
  end

  def user_rented_movies
    @rented = @user.rented
    render json: @rented
  end

  def rent
    @movie.available_copies -= 1
    @movie.save

    @user.rented << @movie
    render json: @movie
  end

  private

  def load_user
    @user = User.find(params[:user_id])
  end

  def load_movie
    @movie = Movie.find(params[:id])
  end

  def user_params
    param.require(:movie).permit(:id, :name)
  end
end
