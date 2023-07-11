require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    before_action :authenticate_request

    def index
      render json: { message: 'Authenticated' }
    end
  end

  describe '#authenticate_request' do
    context 'with a valid token' do
      let(:user) { FactoryBot.create(:user) }
      let(:token) { JWT.encode({ user_id: user.id }, 'your_secret_key', 'HS256') }

      before do
        request.headers['Authorization'] = "Bearer #{token}"
        allow(User).to receive(:find).with(user.id).and_return(user)
      end

      it 'sets the current user' do
        get :index
        expect(assigns(:current_user)).to eq(user)
      end

      it 'allows access to the protected action' do
        get :index
        expect(response).to have_http_status(:ok)
        expect(response.body).to include('Authenticated')
      end
    end

    context 'with an invalid token' do
      before do
        request.headers['Authorization'] = 'Bearer invalid_token'
      end

      it 'returns an unauthorized status' do
        get :index
        expect(response).to have_http_status(:unauthorized)
      end

      it 'returns an error message' do
        get :index
        expect(response.body).to include('Invalid token')
      end
    end
  end
end