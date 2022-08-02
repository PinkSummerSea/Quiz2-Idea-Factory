class IdeasController < ApplicationController
    before_action :find_idea, except: [:index, :new, :create]
    before_action :authenticate_user!, except: [:index, :show]
    before_action :authorize_user!, only: [:edit, :update, :destroy]
    
    def new
        @idea = Idea.new
    end

    def create
        @idea = Idea.new idea_params
        @idea.user = current_user
        if @idea.save
            flash[:notice] = "Successfully Created an Idea"
            redirect_to idea_path(@idea)
        else  
            render :new, status: 303
        end
    end

    def show
        @reviews = @idea.reviews.order(created_at: :desc)
        @review = Review.new
        @like = current_user.likes.find_by_idea_id params[:id]
        # or @like = @idea.likes.find_by(user: current_user)
    end

    def index
        @ideas = Idea.order updated_at: :desc
        
    end

    def edit

    end

    def update
        if @idea.update idea_params
            redirect_to idea_path(@idea)
        else
            render :edit, status: 303
        end
    end

    def destroy
        @idea.destroy
        redirect_to ideas_path, notice: "Idea Deleled"
    end

    private

    def authorize_user!
        redirect_to root_path, alert: "Not Authorized" unless can?(:crud, @idea)
    end

    def find_idea
        @idea = Idea.find params[:id]
    end

    def idea_params
        params.require(:idea).permit!
    end
end
