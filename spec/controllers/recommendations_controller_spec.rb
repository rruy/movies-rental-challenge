require 'rails_helper'

RSpec.describe RecommendationsController, type: :controller do
  describe 'GET #recommendations' do
    it 'returns recommendations for the specified user' do
      user = FactoryBot.create(:user)
      favorite_movies = FactoryBot.create_list(:movie, 2)
      user.favorites << favorite_movies

      # Stub the RecommendationEngine to return mock recommendations
      recommendations = FactoryBot.create_list(:movie, 3)
      recommendation_engine = instance_double('RecommendationEngine')
      allow(RecommendationEngine).to receive(:new).with(favorite_movies).and_return(recommendation_engine)
      allow(recommendation_engine).to receive(:recommendations).and_return(recommendations)

      get :recommend, params: { user_id: user.id }

      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq('application/json; charset=utf-8')

      parsed_response = JSON.parse(response.body)
      expect(parsed_response.length).to eq(3)
    end
  end
end
