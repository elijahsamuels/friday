class SessionsController < ApplicationController
  

  # the line of code below render the view page in app/views/sessions/login.erb
  get '/sessions/login' do
    erb :'sessions/login'
  end

  # find the user who submitted the log in forms by looking in your database 
  # for the user with the email and password from the params
  # sign them in by setting the session[:id] equal to the user's id
  # redirect the user to this route: get '/users/home' 
  # that route is in the Users Controller. Go check out the code there. 
  post '/sessions' do
    @user = User.find_by(email: params["email"], password: params["password"])
    session[:id] = @user.id
      binding.pry

    redirect '/users/home'
  end

  # log out the user by clearing the session hash here
  get "/logout" do
    logout_successful
    session.clear 
    redirect "/"
  end
  
end
 