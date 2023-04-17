class SessionsController < ApplicationController

    def new
        @user = User.new
        render :new
    end

    def create
        username = params[:user][:username]
        password = params[:user][:password]
        @user = User.find_by_credentials(username, password)

        if @user
            session[:session_token] = @user.reset_session_token!
            redirect_to cats_url
        else
            @user = User.new(username: username)
            render :new
        end
    end

    def destroy
        if current_user 
            @current_user.reset_session_token!
        end
        session[:session_token] = nil
    end

end
