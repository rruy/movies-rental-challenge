class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  def self.available_to_rent?(movie_id, user_id)
    @movie = Movie.find_by(id: movie_id)
    @rental = Rental.where(movie_id: movie_id, user_id: user_id)

    return true if (@render.nil? || @rental.delivered_date.nil?) && @movie.available_copies.positive?

    false
  end

  # TODO: Validate if movie is available to rent
  # TODO: Validate if movie is allow to rent for this user and this movie isnt rented now
end
