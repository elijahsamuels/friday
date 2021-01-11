require './config/environment'
require 'sinatra/flash'

class ApplicationController < Sinatra::Base

  # add_flash_types :success, :info, :warning, :danger #these are coming from bootstrap
  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
    register Sinatra::Flash
  end

  get "/" do
    # @user = User.find(session[:id])
    erb :'/index'
  end

  not_found do
    status 404
    erb :error
  end
  
  helpers do

    def logged_in?
      !!User.find_by(id: session[:user_id])
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
      end
    end

    def login_error
      flash[:danger] = "Login error. Please try again."
    end

    def signup_error
      flash[:danger] = "This email is already in use. Please try again."
    end

    def login_successful
      flash[:success] = "Sign in successful!"
    end

    def meeting_saved
      flash[:success] = "Your meeting has been saved!"
    end

    def not_user_object
      flash[:danger] = "Alright Wreck-It Ralph, you know that ain't your business..."
    end

    # def sanitize # make this helper method
    # end
end
