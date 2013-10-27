class UsersController < ApplicationController
  before_filter :find_user, only: [:edit, :update, :show, :destroy]
  def index
    @users = User.all
  end

  def new
    if current_user
      redirect_to root_url
    else
      @user = User.new
      render :layout => 'signing'
    end  
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
    render :layout => 'signing'
  end
  
  def update
    if @user.update_attributes(params[:user])
      redirect_to root_url
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
  end
  
  def destroy
    @user.destroy
    redirect_to root_url
  end
  
  private
    def current_resource
      @current_resource ||= User.find(params[:id]) if params[:id]
    end
    
    def find_user
      @user = User.find(params[:id])
    end
end
