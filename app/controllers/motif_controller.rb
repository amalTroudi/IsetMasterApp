class MotifController < ApplicationController
    before_action :authorize_request
  
    def index
        render json: Motif.all
      end
    
      def create
        @Motif = Motif.new(post_params)
    
        if @Motif.save
          render json: @Motif
        else
          render json: @Motif.errors
        end
      end
    
      def show
        @Motif = Motif.find(params[:id])
        render json: @Motif
      end
    
      def update
        @Motif = Motif.find(params[:id])
    
        if @Motif.update(post_params)
          render json: @Motif
    
        else
          render json: @Motif.errors, statut: :unprocessable_entity
        end
      end
    
      def destroy
        @Motif = Motif.find(params[:id])
        @Motif.destroy
      end
    
      private
    
      def post_params
        params.permit(:reason)
      end
    
      def set_post
        @Motif = Motif.find(params[:id])
      end


end
