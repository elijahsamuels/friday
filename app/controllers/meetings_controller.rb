class MeetingsController < ApplicationController

  # READ
  # GET: /meetings
  get '/meetings' do
    @meeting = Meeting.all
    # session[:user_id] = @user.id
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
    # meeting = Meeting.new(:meetings_user_name => params[:meetings][:user_name], :meetings_client_name => params[:meetings][:client_name])
    @meeting = Meeting.new(params)
    if @meeting.save
      "Your meeting has been saved"
    # take user to the user summeary page
      # redirect "/users/#{@user.id}" 
    else
        erb :'/meetings/new' #let the user try again
    end
    redirect "/meetings/#{@meeting.id}"
  end

  # GET: /meetings/5
  get '/meetings/:id' do
    @meeting = Meeting.find_by_id(params[:id])
     erb :"/meetings/show"
  end

  # GET: /meetings/5/edit
  get "/meetings/:id/edit" do
    erb :"/meetings/edit.html"
  end

  # PATCH: /meetings/5
  patch "/meetings/:id" do
    redirect "/meetings/:id"
  end

  # DELETE: /meetings/5/delete
  delete "/meetings/:id/delete" do
    redirect "/meetings"
  end
end
