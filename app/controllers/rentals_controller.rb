class RentalsController < ApplicationController
  before_action :set_user, :set_movie, only: [:create]

  def rented_by_user
    @rented = User.find_by(id: params[:user_id]).rented
    render json: @rented
  end

  def create
    binding.pry
    return render json: { error: { message: 'Movie not found' } }, status: 404 if @movie.nil?
    return render json: { error: { message: 'User not found' } }, status: 404 if @user.nil?

    # TODO: Validate if movie is available to rent
    # TODO: Validate if movie is allow to rent for this user and this movie isnt rented now

    ActiveRecord::Base.transaction do
      @movie.available_copies -= 1
      @movie.save
      @user.rented << @movie
    end

    render json: @movie
  end

  def rented_return
    # TODO: Included flag to mark that movie is returned.
  end

  private

  def set_user
    @user = User.find_by(id: params[:user_id])
  end

  def set_movie
    @movie = Movie.find_by(id: params[:movie_id])
  end
end
