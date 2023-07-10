class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])
    return render json: {}, status: 404 if @user.nil?

    render json: @user
  end
end
