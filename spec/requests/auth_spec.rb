require 'rails_helper'

RSpec.describe "Auths", type: :request do
  describe "GET /signin" do
    it "returns http success" do
      get "/auth/signin"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /signup" do
    it "returns http success" do
      get "/auth/signup"
      expect(response).to have_http_status(:success)
    end
  end

end
