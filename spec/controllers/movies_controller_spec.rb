require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  CONTENT_TYPE_MATH = /^application\/json(; charset=utf-8)?$/

  describe 'GET #index' do
    it 'returns a JSON response with all movies' do
      FactoryBot.create_list(:movie, 3)

      get :index
      expect(response).to have_http_status(:success)
      expect(response.content_type).to match(CONTENT_TYPE_MATH)

      parsed_response = JSON.parse(response.body)
      expect(parsed_response['movies'].length).to eq(3)
    end
  end
end
