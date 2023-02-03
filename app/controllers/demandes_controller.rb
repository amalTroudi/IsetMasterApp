class DemandesController < ApplicationController

    def index
      render json: Demande.all, include: [:employe, :motif]  
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
      def updateadminimage
        @user = User.find(params[:id])
    
        if @user.update(paramsimagefreelancer)
          render json: @user, methods: [:user_image_url]
    
        else
          render json: @user.errors, statut: :unprocessable_entity
        end
      end


      def paramsimagefreelancer
        
        params.permit(:id, :avatar)
    end

    
      def show
        
        @demande = Demande.find(params[:id])
        render json: @demande
      end
  

     

      def updatedemandebymotif
        @demande = Demande.find(params[:id])
    
        if @demande.update(post_params)
          render json: @demande
    
        else
          render json: @demande.errors, statut: :unprocessable_entity
        end
      end

      def update
        
        @demande = Demande.find(params[:id])
        @motif = Motif.where("id = ?" ,  @demande.motif_id ) 
        @user = User.where("id = ?" ,  @demande.employe_id ) 
        
        if post_params[:status] == "refuse" || post_params[:status] == "encours" || post_params[:status] == 2 || post_params[:status] == 0
          @demande.update(post_params)
            render json: {
            demande:@demande,
            motif: @motif,
            user: @user }

        elsif post_params[:status] == "accepter" || post_params[:status] == 1
      
          demande_days = (@demande.nbr_jours).to_f
          balance_days = @user.pluck(:balance).join(',').to_f       
          result = (balance_days-demande_days).to_f    
          @demande.update(post_params) 
          @user.update_all(:balance => result)
         
          render json: {
            demande: @demande,
            motif: @motif,
            user: @user }
        else
          render json: @demande.errors, statut: :unprocessable_entity
        end
      end


    def static_admin
      @all=Demande.all.count
    @users = User.all.where("role =?", 0).count
   @acepted=Demande.where(status: 1).count()
   @encours= Demande.where(status: 0).count()
   @refused= Demande.where(status: 2).count()

  
   render json:{
    data:[
    all: @all,
    users: @users,
    acepted: @acepted,
    encours: @encours,
    refused: @refused
    ]
  }
    end
    

def demandeid
  
@demandes=Demande.where(employe_id:(params[:employe_id]).to_i)
  
@nbemploye=Demande.where(employe_id:(params[:employe_id])).count()  

render json: {
  demandeid: @demandes,
  nbemploye: @nbemploye
}, include: [:employe, :motif]  

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
        
        params.permit(:start_date, :end_date, :commentaire, :employe_id, :motif_id, :status , :nbr_jours, :id)
      end
    
      def set_post
        @demande = Demande.find(params[:id])
      end


end