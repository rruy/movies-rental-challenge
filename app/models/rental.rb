class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  def self.allow_to_rent?(movie_id, user_id)
    Rental.where(movie_id: movie_id, user_id: user_id).empty?
  end
end
