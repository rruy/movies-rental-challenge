class AuthController < ApplicationController
  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      token = JWT.encode({ user_id: user.id }, 'your_secret_key', 'HS256')
      render json: { token: token }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end
end
