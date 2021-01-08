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
      flash[:success] = "Sign in successful!"
      redirect "/users/#{@user.id}"
    else
      flash[:error] = "login error. please try again."
      erb :"/index"#, danger:"login error. please try again."
    end
  end
  
  # CREATE: /new # this makes the new user. This breaks convention, but it's the same idea.
  get "/signup" do
    erb :'/signup'    
	end
  
  # POST: /users
  post "/signup" do    
    if User.find_by(email: params[:user][:email]) != nil
      flash[:error] = "This email is already in use. Please try again."
      redirect :"/signup"
    end

    @user = User.new(
      :first_name => params[:user][:first_name],
      :last_name => params[:user][:last_name],
      :password => params[:user][:password],
      :email => params[:user][:email])
      
    if @user.save
      session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
    else
      flash[:error] = "Signup error. Please try again."
      redirect :"/signup"
    end

      # if @user[:user][:first_name].empty? || @user[:user][:last_name].empty? || @user[:user][:email].empty? || @user[:user][:password].empty?
      #   flash[:success] = "All fields must be complete!"
      #   erb :'/signup'    
      # elsif User.find_by(username: user.username)
      #   flash[:success] = "This user already exists. Please create new user info.!"
      # else
      #   erb :'/signup'    
      #   @user.save
      #   session[:user_id] = @user.id
      #   redirect "/users/#{@user.id}"
      # end

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
