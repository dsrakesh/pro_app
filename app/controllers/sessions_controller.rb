class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create, :welcome]

  def new
  end

  def login
    render :layout => false
  end


  def logout
    current_user = nil
    redirect_to '/login'
  end

  def create
    @user = User.find_by(username: params[:username], password: params[:password])
    if @user
      redirect_to '/projects'
    else
      redirect_to '/login'
    end
  end
end