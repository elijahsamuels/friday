class MeetingsController < ApplicationController

  get '/meetings' do
    require_login
    @meetings = current_user.meetings
    erb :'/meetings/index'
  end  

  get '/meetings/new' do
    require_login
    booking_date
    erb :'/meetings/new'
  end
  
    # LIVE CODING REQUIREMENT
    # show all the meetings and the users associated with each meeting
    get "/meetings/all" do
      all_meetings 
      require_login
      erb :"/meetings/all"
    end

  post '/meetings' do
    @meeting = Meeting.new(params)
    current_user.meetings << @meeting
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
    require_login
    meeting_find_by_id
    missing_meeting
    if @meeting.user_id == current_user.id
      erb :'/meetings/show'
    else
      not_user_object
      redirect "/meetings"
    end
  end

  get "/meetings/:id/edit" do
    require_login
    meeting_find_by_id
    missing_meeting
    if @meeting.user_id == current_user.id
      erb :'/meetings/edit'
    else
      not_user_object
      redirect '/meetings'
    end
  end
  
  patch "/meetings/:id" do
    meeting_find_by_id
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
    
  delete "/meetings/:id/delete" do
    meeting_find_by_id
    if @meeting.user_id == current_user.id
      @meeting.destroy
      redirect "/meetings"
    else
      not_user_object
      redirect "/meetings"
    end
  end

end