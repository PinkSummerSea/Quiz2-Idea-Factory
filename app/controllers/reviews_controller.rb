class ReviewsController < ApplicationController

    before_action :authenticate_user!

    def create
        @idea = Idea.find params[:idea_id]
        @review = Review.new params.require(:review).permit!
        @review.idea = @idea
        @review.user = current_user
        if @review.save
            redirect_to idea_path(@idea), notice: "Review Posted"
        else   
            @reviews = @idea.reviews.order(created_at: :desc)
            render 'ideas/show', status: 303
        end
    end

    def destroy
        @review = Review.find params[:id]
        @idea = Idea.find params[:idea_id]
        if can?(:crud, @review)
            @review.destroy
            redirect_to idea_path(@idea), notice: "Review Deleted"
        else 
            
            redirect_to idea_path(@idea), notice: "Not Authorized To Delete This"
        end
    end
end
