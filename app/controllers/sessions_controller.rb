class SessionsController < ApplicationController
  

  # the line of code below render the view page in app/views/sessions/login.erb
  get '/sessions/login' do
    erb :'sessions/login'
  end

  # log out the user by clearing the session hash here
  get "/logout" do
    logout_successful
    session.clear 
    redirect "/"
  end
  
end
 