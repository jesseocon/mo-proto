class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      @user.deliver_verification_instructions(@user)
      redirect_to root_url, notice: "Thank you for signing up to FolioShine"
    else
      render :new
    end
  end

  def edit
  end
  
  def update
  
  end

  def show
  end
  
  def destroy
    
  end
end
