class ThrillsController < ApplicationController

# before_action :set_training!, only: []
before_action :set_thrill!, only: [:show, :edit, :update, :destroy]


	def new
      if current_user.id == @training.user.id
# => voor het formulier	    
#	    @thrill = @training.thrills.new
# => aparte sytax hier gebruikt zodat je niet een extra datum in de lijst ziet
		@thrill = Thrill.new training_id: @training.id
	    @training = @thrill.training

# => voor de lijst
	    @thrills = @training.thrills
	  else
        redirect_to root_path, notice: "Geen toegang"
      end
	end

	def create
		@thrill = Thrill.new(thrill_params)
		@trainings = current_user.trainings
		
		if @thrill.save
#			redirect_to thrills_path
			flash[:notice] = "De datum is toegevoegd"

			respond_to :js
		
		else
#			redirect_to thrills_path, notice: "Niet opgeslagen"

		    flash[:notice] = "Niet opgeslagen. Sommige velden zijn niet goed ingevuld" 
			render :index
		end

	end

	def index
#      if current_user.id == @training.user.id
# => voor het formulier	    
#	    @thrill = @training.thrills.new
# => aparte sytax hier gebruikt zodat je niet een extra datum in de lijst ziet
		@trainings = current_user.trainings

		@thrill = Thrill.new
#	    @training = @thrill.training

# => voor de lijst
#	    @thrills = @training.thrills
#	  else
#        redirect_to root_path, notice: "Geen toegang"
#     end


#		thrill = training.thrill
#		@thrills = Thrill.where('? = @thrill.training.user_id', current_user.id).all

	end

	def show
	  if current_user.id == @thrill.training.user.id
      else
        redirect_to root_path, notice: "Je hebt hier helaas geen toegang tot"
      end
	end

	def edit
	end

# deze functie gebruiken we als het goed is niet
	def update
		if @thrill.update(thrill_params)
			redirect_to @thrill
		else
	        flash[:notice] = "Niet opgeslagen. Sommige velden zijn niet goed ingevuld" 
			render :edit
		end
	end

	def destroy
		@thrill = Thrill.find(params[:id])
		@training = @thrill.training
		@thrill.destroy

		redirect_to thrills_path, notice: "De datum is verwijderd"
	end

	private

	def set_training!
		@training = Training.find(params[:training_id])
	end

	def set_thrill!
		@thrill = Thrill.joins(:training).find(params[:id])
		@training = @thrill.training
	end

	def thrill_params
		params.require(:thrill).permit(:thrilldate, :thrillhr, :thrillmin, :time, :training_id)
	end
	
end

