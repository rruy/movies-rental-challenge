require 'rails_helper'

RSpec.describe FavoriteMoviesController, type: :controller do
  let(:user) { User.create(name: 'John') }
  let(:movie) { Movie.create(title: 'Movie 1') }

  describe 'GET #favorites_by_user' do
    it 'returns the favorite movies for a user' do
      user.favorites << movie

      get :favorites_by_user, params: { user_id: user.id }

      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq('application/json; charset=utf-8')

      favorite_movies = JSON.parse(response.body)

      expect(favorite_movies).to be_an(Array)
      expect(favorite_movies.first['title']).to eq('Movie 1')
    end

    it 'returns a not_found error if user is not found' do
      get :favorites_by_user, params: { user_id: 999 }

      expect(response).to have_http_status(:not_found)
      expect(response.content_type).to eq('application/json; charset=utf-8')

      error = JSON.parse(response.body)
      expect(error['error']['message']).to eq('User not found')
    end
  end

  describe 'POST #create' do
    it 'adds a movie to a user\'s favorites' do
      post :create, params: { user_id: user.id, movie_id: movie.id }

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')

      result = JSON.parse(response.body)
      expect(result['message']).to eq('success')
      expect(user.favorites).to include(movie)
    end

    it 'returns a not_found error if movie is not found' do
      post :create, params: { user_id: user.id, movie_id: 999 }

      expect(response).to have_http_status(:not_found)
      expect(response.content_type).to eq('application/json; charset=utf-8')

      error = JSON.parse(response.body)
      expect(error['error']['message']).to eq('Movie not found')
    end

    it 'returns a not_found error if user is not found' do
      post :create, params: { user_id: 999, movie_id: movie.id }

      expect(response).to have_http_status(:not_found)
      expect(response.content_type).to eq('application/json; charset=utf-8')

      error = JSON.parse(response.body)
      expect(error['error']['message']).to eq('User not found')
    end
  end
end
