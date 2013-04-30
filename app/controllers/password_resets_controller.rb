class PasswordResetsController < ApplicationController
  before_filter :load_user_by_reset_token, only: [:edit, :update]
  layout 'signing'
  def new
  end
  
  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    redirect_to root_url, notice: "Email sent with password reset instructions"
  end
  
  def edit 
  end
  
  def update
    if @user.password_reset_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Password reset has expired"
    elsif @user.update_attributes(params[:user])
      redirect_to root_url, notice: "Password has been sent"
    else
      render :edit
    end
  end
  
  private 
    def load_user_by_reset_token
      @user = User.find_by_password_reset_token!(params[:id])
    end
end
