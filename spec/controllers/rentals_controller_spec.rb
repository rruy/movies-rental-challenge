require 'rails_helper'

RSpec.describe RentalsController, type: :controller do
  describe 'GET #user_rented_movies' do
    it 'returns a JSON response with movies rented by a user' do
      # Create a user and their rented movies
      user = FactoryBot.create(:user)
      rented_movies = FactoryBot.create_list(:movie, 2)
      user.rented << rented_movies

      get :rented_by_user, params: { user_id: user.id }

      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq('application/json; charset=utf-8')

      parsed_response = JSON.parse(response.body)
      expect(parsed_response.length).to eq(2)
    end
  end

  describe 'POST #create' do
    let(:user) { User.create(name: 'John') }
    let(:movie) { Movie.create(title: 'Movie 1', available_copies: 1) }

    it 'decreases available_copies of the movie and adds it to user\'s rented movies' do
      # Create a user and a movie with available copies
      user = FactoryBot.create(:user)
      movie = FactoryBot.create(:movie, available_copies: 3)

      post :create, params: { user_id: user.id, movie_id: movie.id }

      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq('application/json; charset=utf-8')

      movie.reload
      user.reload

      expect(movie.available_copies).to eq(2)
      expect(user.rented).to include(movie)
    end

    context 'when movie and user exist' do
      it 'creates a rental for the user' do
        post :create, params: { user_id: user.id, movie_id: movie.id }

        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')

        rental = Rental.last
        expect(rental.movie).to eq(movie)
        expect(rental.user).to eq(user)
      end
    end

    context 'when movie is not available to rent' do
      it 'returns an error message' do
        movie.update(available_copies: 0)
        post :create, params: { user_id: user.id, movie_id: movie.id }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')

        error = JSON.parse(response.body)
        expect(error['error']['message']).to eq('Movie not available to rent')
      end
    end

    context 'when movie or user is not found' do
      it 'returns an error message' do
        post :create, params: { user_id: 999, movie_id: movie.id }

        expect(response).to have_http_status(:not_found)
        expect(response.content_type).to eq('application/json; charset=utf-8')

        error = JSON.parse(response.body)
        expect(error['error']['message']).to eq('User not found')
      end
    end
  end
end
