class ImagesController < ApplicationController
  respond_to :json
  
  def index
    @images = Image.all
  end
  
  def new
    
  end
  
  def create
    puts "****************#{params}"
    @image = Image.new()
    if params['img_url']
      @image.img_url = params['img_url']
      @image.pic_from_url(@image.img_url)
      if @image.save
        respond_with(@image)
      else
        respond_with(@image.errors.full_messages)
      end
    else 
      # @image.img_data = params['img_data'] stub out for base64
      respond_with(@image.errors.full_messages)
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