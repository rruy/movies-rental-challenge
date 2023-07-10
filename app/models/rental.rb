class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  def self.available_to_rent?(movie_id, user_id)
    @movie = Movie.find_by(id: movie_id)
    @rental = Rental.find_by(movie_id: movie_id, user_id: user_id)

    return true if (@rental.nil? || @rental.delivered_date.nil?) && @movie.available_copies.positive?

    false
  end
end
