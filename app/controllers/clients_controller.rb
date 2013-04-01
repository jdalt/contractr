class ClientsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @client = Client.new
  end

  def create
    @client = current_user.clients.new(params[:client])
    if @client.save
      flash[:success] = "Created new client"
      redirect_to user_client_path(current_user, @client)
    else
      render 'new'
    end
  end

  def show
    @client = current_user.clients.find(params[:id])
  end
end
