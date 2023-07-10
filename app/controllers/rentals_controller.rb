class RentalsController < ApplicationController
  before_action :set_user, :set_movie, only: [:create]

  def rented_by_user
    @rented = User.find_by(id: params[:user_id]).rented
    render json: @rented
  end

  def create
    return render json: { error: { message: 'Movie not found' } }, status: 404 if @movie.nil?
    return render json: { error: { message: 'User not found' } }, status: 404 if @user.nil?

    unless Rental.available_to_rent?(@movie.id, @user.id)
      return error('Movie not available to rent', 422)
    end

    ActiveRecord::Base.transaction do
      @movie.available_copies -= 1
      @movie.save
      @user.rented << @movie
    end

    render json: @movie, status: 201
  end

  def rented_return
    @rental = Rental.find_by(movie_id: params[:movie_id], user_id: params[:id])
    return render json: { error: { message: 'Rental not found' } }, status: 404 if @rental.nil?

    @rental.delivered_date = Date.today
    @rental.save

    render json: @rental
  end

  private

  def error(message, status_code)
    render json: { error: { message: message } }, status: status_code
  end

  def set_user
    @user = User.find_by(id: params[:user_id])
  end

  def set_movie
    @movie = Movie.find_by(id: params[:movie_id])
  end
end
