class User < ApplicationRecord
  has_many :favorite_movies
  has_many :favorites, through: :favorite_movies, source: :movie

  has_many :rentals
  has_many :rented, through: :rentals, source: :movie

  has_secure_password
  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}, presence: true, uniqueness: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :password, presence: true, length: { minimum: 6 }

  before_save :downcase_email

  def self.authenticate(email, password)
    user = find_by(email: email)
    return user if user&.authenticate(password)
  end

  private

  def downcase_email
    self.email = email.downcase
  end
end
