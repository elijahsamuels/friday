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
  
  get "/signup" do
    if !logged_in?
      erb :'users/new', locals: {message: "Please sign up before you sign in"}
    else
      redirect to '/show'
    end
	end
  
  # POST: /users
  post "/signup" do
    
		@user = User.new(:first_name => params[:user][:first_name], :password => params[:user][:password], :email => params[:user][:email])
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
    
    # @user = "future use. display user name"
    # @logout = "future use. user logout"
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
    @user.update(:last_name => params[:user][:last_name])

    # @user = self.current_user
    # @user.update_attributes(params[:user])
    # @user.first_name = params[:first_name]
    # @user.email = params[:email]
    # @user.update(change_params(params))
    # @user.last_name = params[:user][:last_name]
    
    @user.save
    # binding.pry
    redirect "/users/#{@user.id}/edit"
  end

  # DELETE: /users/5/delete
  delete "/users/:id/delete" do
    redirect "/users"
  end
end
