class ReservationsController < ApplicationController
	before_action :authenticate_user!, except: [:notify]
#	before_action :set_thrill

	

	def preload
		training = Training.find(params[:training_id])
		today = Date.today
		reservations = training.reservations.where("date >= ?", today)

		render json: reservations
	end

# require 'Mollie/API/Client'
	
	

	def create



		@thrill = Thrill.find(params[:thrill_id])
		if @thrill.reservations.length < @thrill.training.tr_max_attendants
			@reservation = current_user.reservations.create(reservation_params)

			if @reservation

				require 'Mollie/API/Client'

				mollie = Mollie::API::Client.new('test_gUejkz43UkdeCauC22J6UNqqVRdpwW')
			    
			    payment = mollie.payments.create(
			        amount: 10.00,
			        description: 'My first API payment',
			        redirect_Url: 'http://5f142fad.ngrok.io/your_trips',
			        webhookUrl: 'http://5f142fad.ngrok.io/notify',
			        metadata: {
			        	reservation_id: @reservation.id
			        }
			    )

#			    payment = mollie.payments.get(payment.id)

				redirect_to payment.payment_url

#				redirect_to @reservation.thrill.training, notice: "Je training ligt vast, succes!"
			else
				redirect_to @thrill.training, notice: "Helaas, de training is vol"
			end
		end
	end

#		@reservation = Reservation.new(reservation_params)
#		@reservation = @thrill.reservations.new(reservation_params)

	protect_from_forgery except: [:notify]
	def notify
		params.permit!
		status = params[:payment_status]

		reservation = Reservation.find(params[:reservation_id])

		if payment.paid?
		  reservation.update_attributes status:true
		else
			reservation.destroy
		end

		render nothing: true

	end

	protect_from_forgery except: [:your_trips]
	def your_trips
		@reservations = current_user.reservations.joins(:thrill).order('thrills.thrilldate asc').where('? <= thrills.thrilldate', Date.today)
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
