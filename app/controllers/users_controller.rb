class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    if(current_user.id.to_s == params[:id])
      @user = current_user
    else
      redirect_to root_path
    end
  end
end
