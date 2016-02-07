class SessionsController < ApplicationController
  def new
    # renderöi kirjautumissivun
  end

  def create
    user = User.find_by username: params[:username]

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user, notice: "Welcome back #{user.username}"
    else
      redirect_to :back, notice: "User #{params[:username]} does not exist! (which means you don't either)"

    end

  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end
end