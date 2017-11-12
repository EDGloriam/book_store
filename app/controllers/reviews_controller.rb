class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    review = Review.new(permitted_params)
    if review.save
      flash[:success] = I18n.t('controllers.reviews.thanks')
    else
      flash[:danger] = I18n.t('controllers.reviews.error')
    end
    redirect_back(fallback_location: books_path)
  end

  private

    def permitted_params
      params.require(:review).permit(:user_id, :book_id, :rate_stars, :text)
    end
end
