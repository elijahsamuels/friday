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

  helpers do

    def logged_in?
      !!@user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
  end

    # def sanitize # make this helper method
    # end
end


