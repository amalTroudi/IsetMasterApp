class RegistrationsController < ApplicationController

  def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_confirmed = true
      user.confirm_token = nil
      user.save
      redirect_to 'http://localhost:4200/'
    else
    
      render json: { status: 500 }

    end

  end






  def create
    user = User.create!(email: params['user'][:email],
  
      password: params['user'][:password],
      nom: params['user'][:nom],
      prenom: params['user'][:prenom],
      password_confirmation: params['user'][:password_confirmation],
      role: params['user'][:role].to_i)  
      
      if user 
        UserMailer.registration_confirmation(user).deliver
        session[:user_id] = user.id 
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

