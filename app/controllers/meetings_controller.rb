class MeetingsController < ApplicationController

  # before do
  #   require_login
  #   binding.pry
  # end

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
      redirect "/"
    end
  end  

  #CREATE
  # GET: /meetings/new
  get '/meetings/new' do 
    if logged_in?
      @meeting = Meeting.all
      @user = User.find_by_id(session[:user_id])
      erb :'/meetings/new'
    else
      not_user_object
      redirect "/"
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
        # binding.pry
        erb :"/meetings/show"
      end
      
      if !@meeting && !current_user
        erb :"/users/#{@user.id}"
      elsif  @meeting && @meeting.user == current_user
          erb :'/meetings/show'
      else
        not_user_object
        redirect "/meetings"
      end
    end
  end

  # GET: /meetings/5/edit
  get "/meetings/:id/edit" do
    if logged_in?
      @meeting = Meeting.find_by_id(params[:id])
      @user = self.current_user
      unless current_user 
        erb :'/meetings/edit'
      end

      if !@meeting && !current_user
        not_user_object
        redirect '/meetings'
      elsif  @meeting && @meeting.user == current_user
        erb :'/meetings/edit'
      else
        redirect '/meetings/index'
      end
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
    meeting_saved
    redirect "/meetings/#{@meeting.id}"
  end

  # DELETE: /meetings/5/delete
  delete "/meetings/:id/delete" do
    @meeting = Meeting.find(params[:id])
    @meeting.destroy
    redirect "/meetings"
  end

end
