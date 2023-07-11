class ApplicationController < ActionController::API
  def authenticate_request
    header = request.headers['Authorization']
    token = header.split(' ').last if header.present?

    begin
      decoded_token = JWT.decode(token, 'your_secret_key', true, algorithm: 'HS256')
      @current_user = User.find(decoded_token[0]['user_id'])
      rescue JWT::DecodeError, ActiveRecord::RecordNotFound
      render json: { error: 'Invalid token' }, status: :unauthorized
    end
  end

  def params
    request.params
  end
end
