class FoliosController < ApplicationController
  def index
    @folios = Folio.all
  end
  
  def new
    @folio = Folio.new
  end
  
  def create
    @folio = Folio.new(params[:folio])
    if @folio.save
      redirect_to root_url
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
  
  def check_availability
    url = Folio.check_availability(params[:keyword])
    @response = HTTParty.get(url)
    @response = @response["response"]["available"]
    respond_to do |format|
      format.json { render :json => @response}
    end
  end
  
  def register_keyword
    url = Folio.register_keyword(params[:keyword])
    @response = HTTParty.get(url)
    respond_to do |format|
      format.json { render :json => @response }
    end
  end
  
  def deregister_keyword
    url = Folio.deregister_keyword(params[:keyword])
    @response = HTTParty.get(url)
    respond_to do |format|
      format.json { render :json => @response }
    end
  end
  
end



