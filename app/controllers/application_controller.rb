require './config/environment'
require 'sinatra/flash'

class ApplicationController < Sinatra::Base
  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "random_secret"
    register Sinatra::Flash
  end

  get "/" do
    # @user = User.find(session[:id])
    erb :'/index'
  end

  not_found do
    # not_user_object
    erb :error_handling
  end
  
  error do
    # not_user_object
    erb :error
  end

  
  
  helpers do
  
    def require_login
      unless logged_in?
        redirect :'/login'
      end
    end

    def logged_in?
      # !!session[:user_id]
      # !!current_user
      !!User.find_by(id: session[:user_id])
    end
      # a ||= b #assign b to a if a is null or undefined or false (i.e. false-ish value in ruby)
    def current_user
      # User.find(session[:user_id])
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

    def logout_successful
      flash[:success] = "Log out successful!"
    end

    def meeting_saved
      flash[:success] = "Your meeting has been saved!"
    end

    def not_user_object
      flash[:danger] = "Alright Wreck-It Ralph, you know that ain't your business..."
    end

    def meeting_deleted
      flash[:danger] = "That meeting is deleted!"
    end

    def testing_error
      flash[:danger] = "THIS IS A TEST. PLEASE FIX"
    end

    def not_found
      binding.pry # this is a test to see if it works
      raise ActionController::RoutingError.new('Not Found')
    end
    
  end

    # def sanitize # make this helper method
    # end
