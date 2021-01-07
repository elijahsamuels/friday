class UsersController < ApplicationController

  # GET: /users
  get "/users" do
    # @user = User.find(session[:id])
    erb :"/users/index"
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
      "render this as the same page, but display a login error"
    end
  end
  
  # CREATE: /new # this makes the new user
  get "/signup" do
    erb :'/signup'    
	end
  
  # POST: /users
  post "/signup" do
    
    @user = User.new(
      :first_name => params[:user][:first_name],
      :last_name => params[:user][:last_name],
      :password => params[:user][:password],
      :email => params[:user][:email])
		if @user.save
      session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
    else
      @password = params[:user][:password]
      @error = @user.errors.full_messages

      "render this as the same page, but display a signup error"
      # redirect :"/signup"
    end
  end
  
  get '/show' do
    erb :"/show"
  end

  post '/show' do
    @user
    erb :"/show"
  end


  # GET: /users/5
  get "/users/:id" do
    @user = User.find_by_id(params[:id])
    erb :"/users/show"
  end
  
  # GET: /users/5/edit
  get "/users/:id/edit" do
    @user = User.find_by_id(params[:id])
    erb :"/users/edit"
  end
  
  # PATCH: /users/5
  patch "/users/:id" do
    @user = User.find_by_id(params[:id])
    @user.update(
      last_name: params[:user][:last_name],
      first_name: params[:user][:first_name],
      email: params[:user][:email],
      phone: params[:user][:phone])
    @user.save
    redirect "/users/#{@user.id}"
  end

  # DELETE: /users/5/delete
  delete "/users/:id/delete" do
    redirect "/users"
  end

end
