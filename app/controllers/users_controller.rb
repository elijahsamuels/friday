class UsersController < ApplicationController
  
  # GET: /users
  get "/users" do
    if logged_in?
      @user = User.find(session[:id])
      erb :"/users/index"
    else
      login_error
      redirect "/"
    end
  end
  
  # GET: /users/new
  get "/users/new" do
    @user = User.all
    erb :"/users/new"
  end
  
  post "/login" do
    @user = User.find_by(:email => params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
    else
      login_error
      redirect "/"
    end
  end
  
  # CREATE: /new # this makes the new user. This breaks convention, but it's the same idea as new/create
  get "/users/signup" do
    erb :'/users/signup'    
	end
  
  # POST: /users
  post "/users/signup" do    
    @user = User.new(
      :first_name => params[:user][:first_name],
      :last_name => params[:user][:last_name],
      :password => params[:user][:password],
      :phone => params[:user][:phone],
      :email => params[:user][:email])
      
    if @user.save
      session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
    else
      signup_error
      redirect "/users/signup"
    end
  end
  
  # get '/show' do
  #   @user
  #   # binding.pry
  #   erb :"/show"
  # end

  # post '/show' do
  #   @user
  #   erb :"/show"
  # end

  # READ
  # GET: /users/5
  get "/users/:id" do
    @user = User.find_by_id(params[:id])
      if @user.id == current_user.id # this is preventing the user from changing the URL to another users
        erb :"/users/show"
      else 
        not_user_object
        redirect "/users/#{current_user.id}" # this redirects the user back to their user edit page
      end
    end

  # GET: /users/5/edit
  get "/users/:id/edit" do
    @user = User.find_by_id(params[:id])
    if @user.id == current_user.id
      erb :"/users/edit"
    else 
      not_user_object
      redirect "/users/#{current_user.id}/edit" # this redirects the user back to their user edit page
    end
  end
  
  # PATCH: /users/5
  patch "/users/:id" do
    require_login
    @user = User.find_by_id(params[:id])
    if @user.id == current_user.id
      @user.update(
        last_name: params[:user][:last_name],
        first_name: params[:user][:first_name],
        email: params[:user][:email],
        phone: params[:user][:phone])
        @user.save
      redirect "/users/#{@user.id}"
    else 
      # not_user_object
      erb :'/error'
    end
  end

  # DELETE: /users/5/delete
  delete "/users/:id/delete" do
    redirect "/users"
  end

end
