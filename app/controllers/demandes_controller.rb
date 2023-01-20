class DemandesController < ApplicationController

    def index
        render json: Demande.all
      end
    
      def create
        @demande = Demande.new(post_params)
        
        nbr_jours = (@demande.end_date.to_date - @demande.start_date.to_date)+1
        @demande.update(:nbr_jours => nbr_jours ) 
      
if  post_params[:start_date].to_date > post_params[:end_date].to_date
@demande.update(:end_date => post_params[:start_date].to_date)
@demande.update(:start_date => post_params[:end_date].to_date)
end



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
        @motif = Motif.where("id = ?" ,  @demande.motif_id ) 
        @user = User.where("id = ?" ,  @demande.employe_id ) 
      
        if post_params[:status] == 0 || post_params[:status] == 2
          @demande.update(post_params)
            render json: {
            demande:@demande,
            motif: @motif,
            user: @user}

        elsif post_params[:status] == 1
      
          demande_days = (@demande.nbr_jours).to_f
          balance_days = @user.pluck(:balance).join(',').to_f       
          result = (balance_days-demande_days).to_f    
          @demande.update(post_params) 
          @user.update_all(:balance => result)
         
          render json: {
            demande: @demande,
            motif: @motif,
            user: @user}
        else
          render json: @demande.errors, statut: :unprocessable_entity
        end
      end


    def static_admin
   @acepted=Demande.where(status: 1).count()
   @encours= Demande.where(status: 0).count()
   @refused= Demande.where(status: 2).count()

  
   render json:{
    
    acepted: @acepted,
    encours: @encours,
    refused: @refused
  }
    end
    
    def static_employee

    @acepted=Demande.where(status: 1).where(employe_id:(params[:employe_id])).count()
    @encours= Demande.where(status: 0).where(employe_id:(params[:employe_id])).count()
    @refused= Demande.where(status: 2).where(employe_id:(params[:employe_id])).count()
 
   
    render json:{
     
     acepted: @acepted,
     encours: @encours,
     refused: @refused
   }



    end
    
      def destroy
        @demande = Demande.find(params[:id])
        @demande.destroy
      end
    
      private
    
      def post_params
        
        params.permit(:start_date, :end_date, :commentaire, :employe_id, :motif_id, :status , :nbr_jours)
      end
    
      def set_post
        @demande = Demande.find(params[:id])
      end


end