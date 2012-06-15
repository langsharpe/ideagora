class SessionsController < ApplicationController
  def new
  end
  
  def create
    username = (params[:details] || "").gsub(/^@/,'')
    user = User.authenticate(username)
    if user
      session[:user_id] = user.id
      redirect_to root_url, :notice => 'Logged in!'
    else
      flash.now.alert = 'Cannot log you in.'
      render 'new'
    end
  end
  
  def destroy
    session[:user_id] = nil  
    redirect_to root_url, :notice => "Logged out!"
  end
end
