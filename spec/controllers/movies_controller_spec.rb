require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  describe 'GET #index' do
    it 'returns a JSON response with all movies' do
      FactoryBot.create_list(:movie, 3)

      get :index

      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq('application/json; charset=utf-8')

      parsed_response = JSON.parse(response.body)
      expect(parsed_response['movies'].length).to eq(3)
    end
  end

  describe '#search' do
    let(:query) { 'action' }
    let(:movies) { double('movies') }
    let(:results) { { '__expired' => false, 'name' => 'results' } }

    before do
      allow(Movie).to receive(:search).with(query).and_return(movies)
      allow(movies).to receive(:results).and_return(results)
    end

    it 'returns JSON response with search results' do
      get :search, params: { query: query }
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')

      parsed_response = JSON.parse(response.body)
      expect(parsed_response).to eq(results)
    end

    it 'calls Movie.search with the provided query' do
      expect(Movie).to receive(:search).with(query)
      get :search, params: { query: query }
    end
  end

  describe '#show' do
    let(:movie) { FactoryBot.create(:movie) }

    it 'returns JSON response with the requested movie' do
      get :show, params: { id: movie.id }
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')

      parsed_response = JSON.parse(response.body)
      expect(parsed_response['id']).to eq(movie.id)
      expect(parsed_response['title']).to eq(movie.title)
    end

    it 'finds the requested movie by id' do
      expect(Movie).to receive(:find).with(movie.id.to_s).and_return(movie)
      get :show, params: { id: movie.id }
    end
  end
end
