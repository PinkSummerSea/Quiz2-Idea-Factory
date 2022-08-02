class LikesController < ApplicationController
    before_action :authenticate_user!

    def create
        like = Like.new
        idea = Idea.find params[:idea_id]
        like.idea = idea
        like.user = current_user
        if like.save
            redirect_to idea_path(idea), notice: "Thanks For Your Like"
        else  
            redirect_to idea_path(idea), alert: "Cannot Like"
        end

        # quiz does not require that idea author cannot like their own idea. so didn't set up any limitations here.

    end

    def destroy
        idea = Idea.find params[:idea_id]
        like = current_user.likes.find params[:id]
        like.destroy
        redirect_to idea_path(idea), notice: "Like Removed"
    end

    def create_on_index
        like = Like.new
        idea = Idea.find params[:idea_id]
        like.idea = idea
        like.user = current_user
        if like.save
            redirect_to ideas_path, notice: "Thanks For Your Like"
        else  
            redirect_to ideas_path, alert: "Cannot Like"
        end
    end

    def destroy_on_index
        idea = Idea.find params[:idea_id]
        like = current_user.likes.find params[:id]
        like.destroy
        redirect_to ideas_path, notice: "Like Removed"
    end
end
