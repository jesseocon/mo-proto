class MessagesController < ApplicationController
  def index
    
  end
  
  def new
    
  end
  
  def create
    @test = params
    Message.create(params_hash: params)
    respond_to do |format|
      format.json { render :json => @test }
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
