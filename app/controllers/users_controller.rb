class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.new params.require(:user).permit!
        if @user.save
            session[:user_id] = @user.id 
            redirect_to root_path, notice: "Successfully Signed Up"
        else  
            render :new, status: 303
        end
    end
end
