class UsersController < ApplicationController
  def index
    render json: User.all
  end

  def create
    @User = User.new(post_params)

    if @User.save
      render json: @User
    else
      render json: @User.errors
    end
  end

  def show
    @User = User.find(params[:id])
    render json: @User
  end

  def update
    @User = User.find(params[:id])

    if @User.update(post_params)
      render json: @User

    else
      render json: @User.errors, statut: :unprocessable_entity
    end
  end

  def destroy
    @User = User.find(params[:id])
    @User.destroy
  end

  private

  def post_params
    params.permit(:nom, :prenom, :email, :password, :cin, :datenaissance)
  end

  def set_post
    @User = User.find(params[:id])
  end
end
