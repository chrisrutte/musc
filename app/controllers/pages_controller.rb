class PagesController < ApplicationController
  def home
  	@trainings = Training.limit(3)
  end

  def faq
  end

  def search

  	if params[:search].present? && params[:search].strip != ""
  		session[:loc_search] = params[:search]
  	end

  	arrResult = Array.new

  	if session[:loc_search] && session[:loc_search] != ""
  		@trainings_tr_location = Training.where(tr_active: true).near(session[:loc_search], 5, order: 'distance')
  	else
  		@trainings_tr_location = Training.where(tr_active: true).all
  	end

  	@search = @trainings_tr_location.ransack(params[:q])
  	@trainings = @search.result

  	@arrTrainings = @trainings.to_a

    if (params[:startdate] && params[:enddate] && !params[:startdate].empty? & !params[:enddate].empty?)

      startdate = Date.parse(params[:startdate])
      enddate = Date.parse(params[:enddate])

  		@trainings.each do |training|

    # check of er datums zijn voor de training in het datumbereik
      num_thrills = training.thrills.where("(? <= thrilldate AND ? >= thrilldate)", startdate, enddate).length
    # check het totaal aantal reserveringen voor de training in het datumbereik      
      tot_res = training.reservations.where("(? <= thrills.thrilldate AND ? >= thrills.thrilldate)", startdate, enddate).length

    # gooi training eruit als er geen datums beschikbaar zijn in het datumbereik OF als al deze datums vol zitten
  			if (num_thrills == 0 || num_thrills * training.tr_max_attendants == tot_res) 
  				@arrTrainings.delete(training)

  			end
  		end
    end

    if (params[:startdate].blank? & params[:enddate].blank?)
      todate = Date.today

      @trainings.each do |training|

    # check of er datums gepland staan in de toekomst voor deze training
      num_thrills = training.thrills.where("(? <= thrilldate)", todate).length

      # gooi training eruit indien er geen datums in de toekomst zijn
        if (num_thrills == 0) 
          @arrTrainings.delete(training)
        end
      end
    end  	
  end
end

# Welke zaken moeten gelden voor de datum:
# min 1 thrill binnen de gestelde datums
# thrill.reservations.length == thrill.training.tr_max_attendants

# knikker een training eruit indien training.thrills(where thrilldate = date).length = 0
# ook indien training.thrills.where (thrilldate = date ) = training.tr_max_attendan
