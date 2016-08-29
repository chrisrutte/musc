class ReservationsController < ApplicationController
	before_action :authenticate_user!
#	before_action :set_thrill

	def preload
		training = Training.find(params[:training_id])
		today = Date.today
		reservations = training.reservations.where("date >= ?", today)

		render json: reservations
	end


	def create
		@thrill = Thrill.find(params[:thrill_id])
		if @thrill.reservations.length < @thrill.training.tr_max_attendants
			@reservation = current_user.reservations.create(reservation_params)
			redirect_to @reservation.thrill.training, notice: "Je training ligt vast, succes!"
		else
			redirect_to @thrill.training, notice: "Helaas, de training is vol"
		end


#		@reservation = Reservation.new(reservation_params)
#		@reservation = @thrill.reservations.new(reservation_params)

		
	end

	def your_trips
		@reservations = current_user.reservations
	end

	def your_reservations
		@trainings = current_user.trainings
	end

	private
		def reservation_params
# => Deze gaf een foutmelding. Ik weet niet welke andere implicatie het geeft om nu de andere te gebruiken maar deze werkt.			
#			params.require(:reservation).permit(:thrill_id, :user_id)
			params.permit(:thrill_id, :user_id)
		end

#		def set_thrill
#			@thrill = Thrill.find(params[:thrill_id])
#		end
	end
