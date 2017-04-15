class ReviewsController < ApplicationController

  # before_filter :create, :destroy

  def create
    @review = Review.new(review_params)
    if @review.save
      flash.notice = 'Review was saved successfully'
    else
      flash.now.alert = 'There was an error'
    end
    redirect_to @review.product
  end

  def destroy
    @review = Review.find params[:id]
    @review.destroy
    redirect_to @review.product, notice: 'Review deleted'
  end

  private

  def review_params
    params.require(:review).permit(:product_id, :user_id, :description, :rating)
  end
end
