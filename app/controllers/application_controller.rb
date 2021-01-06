require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get "/" do
    # @user = User.find(session[:id])
    erb :'/index'
  end

# minimize routes in application controller

  helpers do

    def logged_in?
      !!@user
      binding.pry
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
  end

    # def sanitize # make this helper method
    # end



  end


