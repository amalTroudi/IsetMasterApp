class DemandesController < ApplicationController

    def index
        render json: Demande.all
      end
    
      def create
        @demande = Demande.new(post_params)
      
        if @demande.save
          render json: @demande
        
          
        else
          render json: @demande.errors
        end
        
      end
    
      def show
        @demande = Demande.find(params[:id])
        render json: @demande
      end
    
      def update
        @demande = Demande.find(params[:id])
    
        if @demande.update(post_params)
          render json: @demande
    
        else
          render json: @demande.errors, statut: :unprocessable_entity
        end
      end
    
      def destroy
        @demande = Demande.find(params[:id])
        @demande.destroy
      end
    
      private
    
      def post_params
        
        params.permit(:start_date, :end_date, :commentaire, :employe_id, :motif_id, :status)
      end
    
      def set_post
        @demande = Demande.find(params[:id])
      end


end