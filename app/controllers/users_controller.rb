class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])
		@trainings = @user.trainings
	end
end
