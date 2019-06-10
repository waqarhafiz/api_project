class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: %i[login register]
  before_action :check_params ,only: [:register]

  # POST /register
  def register

    @user = User.new(user_params)
    if @user.save
      render json: {
          message: 'Successfully Sign Up',
          status: :created
      }
    else
      # byebug
      render json:  @user.errors.to_h, status: :bad
    end
  end
  def login
    authenticate params[:email], params[:password]
  end
  def test
    render json: {
        message: 'You have passed authentication and authorization test'
    }
  end

  private
  def check_params
    return bad_request_error("name is missing") unless params[:name].present?
    return bad_request_error("email is missing" )unless params[:email].present?
    return bad_request_error("password is missing") unless params[:password].present?
    return bad_request_error("password_confrimation is missing") unless params[:password_confirmation].present?

  end

  def bad_request_error(error_message)
    render json: {
        message: error_message
    }

  end

  def authenticate(email, password)
    command = AuthenticateUser.call(email, password)

    if command.success?
      render json: {
          access_token: command.result,
          message: 'Login Successful'
      }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end

  def user_params
    params.permit(
        :name,
        :email,
        :password,
         :password_confirmation
    )
  end
end