class ReviewsController < ApplicationController

	def create
		@review = current_user.reviews.create(review_params)
		redirect_to @review.training
	end

	def destroy
		@review = Review.find(params[:id])
		training = @review.training
		@review.destroy

		redirect_to training
	end

	private
		def review_params
			params.require(:review).permit(:comment, :star, :training_id)
	end		

end