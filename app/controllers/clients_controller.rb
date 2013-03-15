class ClientsController < ApplicationController

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(params[:client])
    if @client.save
      flash[:success] = "Created new client"
      redirect_to @client
    else
      render 'new'
    end
  end

  def show
    @client = Client.find(params[:id])
  end
end
