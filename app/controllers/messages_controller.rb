class MessagesController < ApplicationController
  def index
    @messages = Message.all
  end
  
  def new
    
  end
  
  def create
    message_hash = {
      :campaign_id  => params["campaign_id"],
      :msisdn       => params["msisdn"],
      :carrier      => params["carrier"],
      :message      => params["message"],
      :image_url    => params["images"]["image"]
    }
    Message.create(message_hash)
    respond_to do |format|
      format.json { render :json => message_hash }
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
