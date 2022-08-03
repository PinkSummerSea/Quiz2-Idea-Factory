class SessionsController < ApplicationController

    def new
    end

    def create
        @user = User.find_by_email params[:email]
        if @user && @user.authenticate(params[:password]) # why this method requires parentheses?
            session[:user_id] = @user.id
            redirect_to root_path, notice: "Welcome Back"
        else  
            render :new, status: 303
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to root_path, notice: "Logged Out"
    end
end
