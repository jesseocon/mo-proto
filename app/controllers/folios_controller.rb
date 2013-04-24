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
  
  def keyword_available
    puts "**********************#{params}"
    @response = Folio.check_availability(params[:keyword])
    respond_to do |format|
      format.json { render :json => @response }
    end
  end
  
  private 
end



