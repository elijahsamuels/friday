class MeetingsController < ApplicationController

  get '/meetings' do
    require_login
    @user = User.find_by_id(session[:user_id])
    if @user
        @meetings = @user.meetings
      erb :'/meetings/index'
    else
      not_user_object
      redirect "/"
    end
  end  

  get '/meetings/new' do
    booking_date
    require_login
    @meeting = Meeting.all
    @user = User.find_by_id(session[:user_id])
    erb :'/meetings/new'
  end
  
    # LIVE CODING REQUIREMENT
    # show all the meetings and the users associated with each meeting
    get "/meetings/all" do
      @meetings = Meeting.all
      if current_user
        erb :"/meetings/all"
      else
        redirect "/meetings"
      end
    end

  post '/meetings' do
    require_login
    @meeting = Meeting.new(params)
    @user = User.find_by_id(session[:user_id])
    @user.meetings << @meeting
    if @meeting.save
      meeting_saved
      redirect "/meetings/#{@meeting.id}"
    else
      erb :'/meetings/new' #let the user try again
    end
  end
  
  get '/show' do
    erb :"/show"
  end 
  
  post '/show' do
    @meeting
    erb :"/show"
  end
  
  get '/meetings/:id' do
    @meeting = Meeting.find_by_id(params[:id])
    missing_meeting
    if @meeting.user_id == current_user.id
      erb :'/meetings/show'
    else
      not_user_object
      redirect "/meetings"
    end
  end

  get "/meetings/:id/edit" do
    @meeting = Meeting.find_by_id(params[:id])
    missing_meeting
    if @meeting.user_id == current_user.id
      erb :'/meetings/edit'
    else
      not_user_object
      redirect '/meetings'
    end
  end
  
  patch "/meetings/:id" do
    require_login
    @meeting = Meeting.find_by_id(params[:id])
    if @meeting.user_id == current_user.id
      @meeting.update(
        user_name: params[:meeting][:user_name],
        client_name: params[:meeting][:client_name],
        meeting_date: params[:meeting][:meeting_date],
        meeting_time: params[:meeting][:meeting_time])
        @meeting.save
        meeting_saved
        redirect "/meetings/#{@meeting.id}"
      else
        redirect '/meetings'
      end
  end
    
    # add same protections from PATCH
  delete "/meetings/:id/delete" do
    require_login
    @meeting = Meeting.find(params[:id])
    if @meeting.user_id == current_user.id
      @meeting.destroy
      redirect "/meetings"
    else
      not_user_object
      redirect "/meetings"
    end
  end

end


# remove any references @user = current_user
# go through the code and remove unneccessary code
# utilize require_login instead of nested IF statements
# send github link


# utilize require_login instead if nested if statements
# remove references @user = current_user
# Finish the live coding task
# Protect the delete route from hackers who try to delete a meeting that does not belong to them.