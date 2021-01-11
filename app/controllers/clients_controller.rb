class ClientsController < ApplicationController

  # GET: /clients
  get "/clients" do
    erb :"/clients/index"
  end

  # GET: /clients/new
  get "/clients/new" do
    erb :"/clients/new"
  end

  # POST: /clients
  post "/clients" do
    redirect "/clients"
  end

  # GET: /clients/5
  get "/clients/:id" do
    erb :"/clients/show"
  end

  # GET: /clients/5/edit
  get "/clients/:id/edit" do
    erb :"/clients/edit"
  end

  # PATCH: /clients/5
  patch "/clients/:id" do
    redirect "/clients/:id"
  end

  # DELETE: /clients/5/delete
  delete "/clients/:id/delete" do
    redirect "/clients"
  end
end
