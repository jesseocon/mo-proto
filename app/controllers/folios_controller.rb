class FoliosController < ApplicationController
  def index
    @folios = Folio.all
  end
  
  def new
    @folio = Folio.new
    @packages = Package.all
  end 
 
  def create
    @user = current_user
    @packages = Package.all
    @package = Package.find(params[:package][:id])
    
    @folio = @user.folios.new(
      :name           => params[:keyword],
      :keyword        => params[:keyword],
      :stripe_token   => params[:stripe_token],
      :package_price  => (@package.price * 100).to_i,
      :user_id        => current_user.id,
      :limit          => @package.photo_qty
    )
    if @folio.save
      redirect_to folio_path(@folio)
    else
      render :new
    end
  rescue Stripe::CardError => e 
    flash[:error] = e.message
    url = Folio.deregister_keyword(params[:keyword])
    @response = HTTParty.get(url)
    puts "***************ERROR MESSAGE#{e.message}"
    redirect_to root_url
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def show
    @packages = Package.all
    @folio = Folio.find(params[:id])
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



