class SessionsController < ApplicationController
  

  get '/sessions/login' do

    # the line of code below render the view page in app/views/sessions/login.erb
    erb :'sessions/login'
  end

  post '/sessions' do
    # find the user who submitted the log in forms by looking in your database 
    #   for the user with the email and password from the params
    # sign them in by setting the session[:id] equal to the user's id

    # redirect the user to this route: get '/users/home' 
    #  that route is in the Users Controller. Go check out the code there. 
    @user = User.find_by(email: params["email"], password: params["password"])
    session[:id] = @user.id
    redirect '/users/home'
  end

  get '/sessions/logout' do 
    # log out the user by clearing the session hash here
    session.clear
    redirect '/'
  end

  get '/login_error' do
    @error_message
  end

  get '/signup_error/' do
    "There seems to be an error with your email or password."

  end

  get "/logout" do
    session.clear
    redirect "/"
  end


helpers do
  def logged_in?
    !!session[:id]
  end

  def current_user
    User.find(session[:user_id])
  end
  end

end
