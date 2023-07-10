require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #show' do
    it 'renders the user JSON'
      user = User.create(name: 'John')

      get :show, params: { id: user.id }

      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq('application/json; charset=utf-8')

      user_json = JSON.parse(response.body)
      expect(user_json['name']).to eq('John')
    end

    it 'returns a 404 error if user is not found' do
      get :show, params: { id: 999 }
      expect(response).to have_http_status(:not_found)
    end
  end
end
