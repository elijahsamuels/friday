class MeetingsController < ApplicationController

  # READ
  # Index
  # GET: /meetings
  get '/meetings' do
    @user = User.find_by_id(session[:user_id])
    if @user
      @meetings = @user.meetings
      erb :'/meetings/index'
    else
      not_user_object
      redirect :"/meetings"
    end
  end  

  #CREATE
  # GET: /meetings/new
  get '/meetings/new' do 
    if logged_in?
      @meeting = Meeting.all
      erb :'/meetings/new'
    else
      not_user_object
      redirect :"/meetings"
    end
  end
  
  #CREATE
  # POST: /meetings
  post '/meetings' do
    current_user
    @meeting = Meeting.new(params)
    @user = User.find_by_id(session[:user_id])
    @user.meetings << @meeting
      if @meeting.save
        meeting_saved
        # take user to the user summeary page
        # redirect "/users/#{@user.id}" 
      else
        erb :'/meetings/new' #let the user try again
      end
    redirect "/meetings/#{@meeting.id}"
  end
  
  get '/show' do
    erb :"/show"
  end
  
  post '/show' do
    @meeting
    erb :"/show"
  end
  
  # check to see if the user is NOT nil, 
  # GET: /meetings/5
  get '/meetings/:id' do
    if logged_in?
      @meeting = Meeting.find_by_id(params[:id])
      @user = self.current_user

      unless current_user 
        erb :"/meetings/show"
      end

      if !@meeting && !current_user
        erb :"/users/#{@user.id}"
      elsif  @meeting && @meeting.user == current_user
          erb :'/meetings/show'
      else
        not_user_object
        redirect :'/meetings'
      end
    end
  end

    # ############

    #     if @user.id == @meeting.user_id
    #       erb :"/meetings/show"
    #     else
    #       not_user_object
    #       redirect :"/meetings"
    #     end
    #     # erb :"/meetings/show"
    #   else
    #     # redirect '/login'
    #     "You're not logged in!"
    #   end
    # end

  # GET: /meetings/5/edit
  get "/meetings/:id/edit" do
    if logged_in?
      @meeting = Meeting.find_by_id(params[:id])
      @user = self.current_user
        if @user.id == @meeting.user_id
          meeting_saved
          erb :"/meetings/edit"
        else
          not_user_object
          redirect :"/meetings"
        end
      else
        not_user_object
        redirect :"/meetings"
      end
    end
  
  # PATCH: /meetings/5
  patch "/meetings/:id" do
    current_user
    @meeting = Meeting.find_by_id(params[:id])
    @meeting.update(
      user_name: params[:meeting][:user_name],
      client_name: params[:meeting][:client_name])
    @meeting.save
    redirect "/meetings/#{@meeting.id}"
  end

  # DELETE: /meetings/5/delete
  delete "/meetings/:id/delete" do
    @meeting = Meeting.find(params[:id])
    @meeting.destroy
    redirect "/meetings"
  end
end
