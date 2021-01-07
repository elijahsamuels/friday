class MeetingsController < ApplicationController

  # READ
  # GET: /meetings
  get '/meetings' do
    @user = User.find_by_id(session[:user_id])
    @meetings = @user.meetings
    erb :'/meetings/index'
  end
  
  #CREATE
  # GET: /meetings/new
  get '/meetings/new' do 
    @meeting = Meeting.all
    erb :'/meetings/new'
  end
  
  #CREATE
  # POST: /meetings
  post '/meetings' do
    @meeting = Meeting.new(params)
    @user = User.find_by_id(session[:user_id])
    @user.meetings << @meeting
    if @meeting.save
      "Your meeting has been saved"
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
  
  # GET: /meetings/5
  get '/meetings/:id' do
    @meeting = Meeting.find_by_id(params[:id])
     erb :"/meetings/show"
  end

  # GET: /meetings/5/edit
  get "/meetings/:id/edit" do
    @user = User.find_by_id(params[:id])
    @meeting = Meeting.find_by_id(params[:id])
    # binding.pry
    erb :"/meetings/edit"
  end

  # PATCH: /meetings/5
  patch "/meetings/:id" do
    @meeting = Meeting.find_by_id(params[:id])
    @meeting.update(
      user_name: params[:meeting][:user_name],
      client_name: params[:meeting][:client_name])
    @meeting.save
    redirect "/meetings/#{@meeting.id}"
  end

  # DELETE: /meetings/5/delete
  delete "/meetings/:id/delete" do
    redirect "/meetings"
  end
end
