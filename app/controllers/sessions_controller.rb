class SessionsController < ApplicationController
  layout 'signing'
  def new
  end
  
  def create
    @user = User.find_by_email(params[:email])
    if (@user && @user.authenticate(params[:password])) && @user.verified == true
      if params[:remember_me]
        cookies.permanent[:auth_token] = @user.auth_token
      else
        cookies[:auth_token] = @user.auth_token
      end
        redirect_to root_url, notice: "Logged in!"
    elsif (@user && @user.authenticate(params[:password])) && @user.verified.nil?
      flash.now[:error] = "You have to verify your account first"
      redirect_to login_url
    else
      flash.now[:error] = "Email or password is invalid"
      render "new"
    end
  end
  
  def destroy
    cookies.delete(:auth_token)
    redirect_to root_url, notice: "Logged Out!"
  end
end
