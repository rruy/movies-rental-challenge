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

  describe 'POST #rent' do
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
  end
end
