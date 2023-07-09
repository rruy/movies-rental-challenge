class FavoriteMoviesController < ApplicationController
  def favorites_by_user
    @favorite_movies = User.find_by(id: params[:user_id]).favorites
    render json: @favorite_movies
  end

  def create
    @movie = Movie.find_by(id: params[:movie_id])
    @user = User.find_by(id: params[:user_id])

    return render json: { error: { message: 'Movie not found' } }, status: 404 if @movie.nil?
    return render json: { error: { message: 'User not found' } }, status: 404 if @user.nil?

    @user.favorites << @movie

    render json: { message: 'success' }, status: 200
  end
end
