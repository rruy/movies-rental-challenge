class User < ApplicationRecord
  
  # ????? Precisa de duas declarações
  has_many :favorite_movies
  has_many :favorites, through: :favorite_movies, source: :movie
  
  has_many :rentals
  has_many :rented, through: :rentals, source: :movie

  validates :name, presence: true
end
