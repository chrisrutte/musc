class TrainingsController < ApplicationController

  before_action :set_training, only: [:show, :edit, :update]
  before_action :authenticate_user!, except: [:show]
#  around_action :set_booked, only: [:show]


  def index
    @trainings = current_user.trainings
  end

  def show
    @photos = @training.photos
    @thrills = @training.thrills
#    @thrill = Thrill.find(params[thrill_id])





# => te repareren. Voor iedere thrill moet de check gemaakt worden of de gebruiker al is ingeschreven


#   @booked = Reservation.where("thrill_id = ? AND user_id = ?", thrill.id, current_user.id).present? if current_user

#   @thrills.each do |thrill|

#      thrill.booked = Reservation.where("thrill_id = ? AND user_id = ?", thrill.id, current_user.id).present? if current_user

#   end

#   @reviews = @training.reviews
#   @hasReview = @reviews.find_by(user_id: current_user.id) if current_user
  end

  def new
    @training = current_user.trainings.build
  end

  def create
    @training = current_user.trainings.build(training_params)
       
    if @training.save

      if params[:images]
        params[:images].each do |image|
          @training.photos.create(image: image)
        end
      end

      @photos = @training.photos

      redirect_to edit_training_path(@training), notice: "Saved..."
    else
      render :new
    end
  end

  def edit
    if current_user.id == @training.user.id
        @photos = @training.photos
#       @thrill = @training.thrills.create(thrill_params)
#       @thrills = @training.thrills
      else
        redirect_to root_path, notice: "Je hebt hier helaas geen toegang tot"
      end
  end

  def update
        if @training.update(training_params)

          if params[:images]
            params[:images].each do |image|
              @training.photos.create(image: image)
            end
          end

#         @thrill = @training.thrills.create(thrill_params)
#         @thrills = @training.thrills

          @photos = @training.photos

          redirect_to edit_training_path(@training), notice: "Updated..."
        else
          render:edit
        end
  end


  private
    def set_training
      @training = Training.find(params[:id])
    end

    def training_params
      params.require(:training).permit(:tr_type, :tr_intensity, :tr_name, :tr_description, :tr_location, :tr_time, :tr_max_attendants, :tr_price, :tr_duration, :tr_gender, :tr_active)
    end

#    def set_booked
#      @booked = Reservation.where("thrill_id = ? AND user_id = ?", thrill.id, current_user.id).present? if current_user
#    end

end
