class ApplicationController < ActionController::API
  def home
    render json: { status: "it's working" }
  end
end
