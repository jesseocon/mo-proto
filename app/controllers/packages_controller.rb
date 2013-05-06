class PackagesController < ApplicationController
  before_filter :find_package, only: [:edit, :update, :show, :destroy]
  def index
    @packages = Package.all
  end
  
  def new
    @package = Package.new
  end
  
  def create
    @package = Package.new(params[:package])
    if @package.save
      redirect_to packages_path
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @package.update_attributes(params[:package])
      redirect_to packages_path
    else
      render :edit
    end
  end
  
  def show
  end
  
  def destroy
    @package.destroy
  end
  
  private 
    def find_package
      @package = Package.find(params[:id])
    end
end
