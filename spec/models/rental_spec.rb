require 'rails_helper'

RSpec.describe Rental, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:movie) }
  end

  describe 'validations' do
    let(:user) { User.create(name: 'John') }
    let(:movie) { Movie.create(title: 'Movie 1') }
    let(:rental) { Rental.new(user: user, movie: movie) }

    it 'is valid with valid attributes' do
      expect(rental).to be_valid
    end

    it 'is not valid without a user' do
      rental.user = nil
      expect(rental).not_to be_valid
    end

    it 'is not valid without a movie' do
      rental.movie = nil
      expect(rental).not_to be_valid
    end
  end

  describe '.available_to_rent?' do
    let(:movie) { Movie.create(title: 'Movie 1', available_copies: 1) }
    let(:user) { User.create(name: 'John') }

    context 'when rental is not present and movie has available copies' do
      it 'returns true' do
        result = Rental.available_to_rent?(movie.id, user.id)
        expect(result).to be(true)
      end
    end

    context 'when rental is not present but movie does not have available copies' do
      it 'returns false' do
        movie.update(available_copies: 0)

        result = Rental.available_to_rent?(movie.id, user.id)

        expect(result).to be(false)
      end
    end

    context 'when rental is present but movie does not have available copies' do
      it 'returns false' do
        Rental.create(movie: movie, user: user, delivered_date: Time.now)

        result = Rental.available_to_rent?(movie.id, user.id)

        expect(result).to be(false)
      end
    end

    context 'when rental is present and movie has available copies' do
      it 'returns false' do
        movie.update_attribute(:available_copies, 0)

        Rental.create(movie: movie, user: user)

        result = Rental.available_to_rent?(movie.id, user.id)

        expect(result).to be(false)
      end
    end
  end
end
