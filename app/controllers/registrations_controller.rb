class RegistrationsController < ApplicationController
  before_action :authorize_request
  default :from => "amine@gmail.com"
  def create
    user = User.create!(
      
      email: params[:email],
  
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      role: params[:role].to_i,
      User.registration_confirmation(@user).deliver
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


  @user = User.new(user_params)    
  if @user.save
    UserMailer.registration_confirmation(@user).deliver
  end

  
if user
  user.email_activate
end




end
end
