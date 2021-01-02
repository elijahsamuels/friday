class MeetingsController < ApplicationController

  # GET: /meetings
  get "/meetings" do
    erb :"/meetings/index.html"
  end

  # GET: /meetings/new
  get "/meetings/new" do
    erb :"/meetings/new.html"
  end

  # POST: /meetings
  post "/meetings" do
    redirect "/meetings"
  end

  # GET: /meetings/5
  get "/meetings/:id" do
    erb :"/meetings/show.html"
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
