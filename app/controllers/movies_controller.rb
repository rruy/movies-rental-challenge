class MoviesController < ApplicationController
  def index
    @movies = Movie.all.page(params[:page]).per(10)

    render json: {
      movies: @movies,
      total_pages: @movies.total_pages,
      total_count: @movies.total_count,
      current_page: @movies.current_page
    }
  end

  def show
    @movie = Movie.find(params[:id])
    render json: @movie
  end

  private

  def user_params
    param.require(:movie).permit(:id, :name)
  end
end
