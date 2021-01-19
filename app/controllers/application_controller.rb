require './config/environment'
require 'sinatra/flash'
require 'date'

class ApplicationController < Sinatra::Base
  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "random_secret"
    register Sinatra::Flash
  end

  get "/" do
    @meeting = Meeting.all
    @user = User.find_by_id(session[:user_id])
    if logged_in? 
      not_user_object
      redirect '/meetings'
    else
      erb :'/index'
    end   
  end

  not_found do
    redirect '/'
  end
  
  
  error do
    # not_user_object
    erb :error
  end
  
  helpers do
    
    def missing_meeting
      if Meeting.find_by_id(params[:id]) == nil
        redirect '/'
      end
    end

    def require_login
      unless logged_in?
        redirect '/login'
      end
    end

    def logged_in?
      !!current_user # returns "true" if the current user is logged in
    end

      # a ||= b #assign b to a if a is null or undefined or false (i.e. false-ish value in ruby)
    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
      end
    end

    def login_error
      flash[:danger] = "You must be logged in for that."
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

    def date_current
      DateTime.current.strftime("%Y-%m-%d")
    end

    def booking_date
      DateTime.current + 48.hours
    end

  end