class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]
  def index
    @users = User.all
    render json: @users
  end

  def create
    user = User.create(user_params)
    if user.valid?
      command = AuthenticateUser.call(params[:email], params[:password])
      render json: { user: user, jwt: command.result, message: 'Account Created' }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :not_acceptable
    end
  end

  def attendees
    render json: User.where("role = ?", "attendee")
  end

  private

  def user_params
    params.permit(:name, :email, :password, :role)
  end
end
