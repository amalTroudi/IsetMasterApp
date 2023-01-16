class RegistrationsController < ApplicationController
  before_action :authorize_request

  def create
    user = User.create!(
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      role: params[:role].to_i
    )

    if user
      
      render json: {
        status: :created,
        user: user
      }

    else
      render json: {
        status: 500
      }

    end
  end
end
