require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  CONTENT_TYPE_MATH = /^application\/json(; charset=utf-8)?$/

  describe 'GET #index' do
    it 'returns a JSON response with all movies' do
      # Create some sample movies using FactoryBot or create them manually
      movies = FactoryBot.create_list(:movie, 3)

      get :index
      expect(response).to have_http_status(:success)
      expect(response.content_type).to match(CONTENT_TYPE_MATH)

      parsed_response = JSON.parse(response.body)
      expect(parsed_response['movies'].length).to eq(3)
    end
  end

  describe 'GET #recommendations' do
    it 'returns a JSON response with movie recommendations for a user' do
      # Create a user and their favorite movies
      user = FactoryBot.create(:user)
      favorite_movies = FactoryBot.create_list(:movie, 2)
      user.favorites << favorite_movies

      # Stub the RecommendationEngine to return mock recommendations
      recommendations = FactoryBot.create_list(:movie, 3)
      recommendation_engine = instance_double('RecommendationEngine')
      allow(RecommendationEngine).to receive(:new).with(favorite_movies).and_return(recommendation_engine)
      allow(recommendation_engine).to receive(:recommendations).and_return(recommendations)

      get :recommendations, params: { user_id: user.id }
      expect(response).to have_http_status(:success)
      expect(response.content_type).to match(CONTENT_TYPE_MATH)

      parsed_response = JSON.parse(response.body)
      expect(parsed_response.length).to eq(3)
    end
  end

  describe 'GET #user_rented_movies' do
    it 'returns a JSON response with movies rented by a user' do
      # Create a user and their rented movies
      user = FactoryBot.create(:user)
      rented_movies = FactoryBot.create_list(:movie, 2)
      user.rented << rented_movies

      get :user_rented_movies, params: { user_id: user.id }
      expect(response).to have_http_status(:success)
      expect(response.content_type).to match(CONTENT_TYPE_MATH)

      parsed_response = JSON.parse(response.body)
      expect(parsed_response.length).to eq(2)
    end
  end

  describe 'POST #rent' do
    it 'decreases available_copies of the movie and adds it to user\'s rented movies' do
      # Create a user and a movie with available copies
      user = FactoryBot.create(:user)
      movie = FactoryBot.create(:movie, available_copies: 3)

      post :rent, params: { user_id: user.id, id: movie.id }
      expect(response).to have_http_status(:success)
      expect(response.content_type).to match(CONTENT_TYPE_MATH)

      movie.reload
      user.reload

      expect(movie.available_copies).to eq(2)
      expect(user.rented).to include(movie)
    end
  end
end
