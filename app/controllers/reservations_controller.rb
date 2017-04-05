

class ReservationsController < ApplicationController
	before_action :authenticate_user!, except: [:notify]
	skip_before_filter :verify_authenticity_token
	protect_from_forgery except: [:notify, :your_trips]




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

			if @reservation


				require 'mollie/api/client'

				mollie = Mollie::API::Client.new('live_AGgqn6FwbtDCPyWsNDv4VqzUhsfbr8')
			    
			    payment = mollie.payments.create(
			        amount: @reservation.thrill.training.tr_price,
			        description: 'Musc: ' + @reservation.thrill.training.tr_name,
			        redirect_Url: 'https://whispering-garden-94462.herokuapp.com/your_trips',
			        webhookUrl: 'https://whispering-garden-94462.herokuapp.com/notify',
			        metadata: {
			        	reservationid: @reservation.id
			        }
			    )



				@reservation.update_attributes payid:payment.id

				redirect_to payment.payment_url


			else
				redirect_to @thrill.training, notice: "Helaas, de training is vol"
			end
		end
	end

#		@reservation = Reservation.new(reservation_params)
#		@reservation = @thrill.reservations.new(reservation_params)

	
#	protect_from_forgery with: :null_session, if: -> {request.format.json?}

	def notify

		require 'mollie/api/client'

		mollie = Mollie::API::Client.new('live_AGgqn6FwbtDCPyWsNDv4VqzUhsfbr8')

		payment = mollie.payments.get(params[:id])

#		params.permit!
#		status = params[:status]

		if payment.paid?
		  
		  reservation = Reservation.find(payment.metadata.reservationid)
		  reservation.update_attributes status:true
		else
			reservation.destroy
		end

		render nothing: true

	end


	def your_trips
		@reservations = current_user.reservations.joins(:thrill).order('thrills.thrilldate asc').where('? <= thrills.thrilldate AND status = ?', Date.today, true)
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
