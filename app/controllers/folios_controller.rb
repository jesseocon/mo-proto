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
    @package = Package.find(params[:package][:id])
    @amount = (@package.price * 100).to_i
    
    customer = Stripe::Customer.create(
      :email      => @user.email,
      :card       => params[:stripe_token]
    ) 
    
    charge = Stripe::Charge.create(
      :customer     => customer.id,
      :amount       => @amount,
      :description  => "Rails Stripe Customer",
      :currency     => 'usd'
    )
    
    @folio = Folio.new(
      :name       => params[:keyword],
      :keyword    => params[:keyword]
    )
    @folio.save
    
    @user.update_attributes(
      :stripe_id      => customer.id,
      :last_4_digits  => params[:last_4_digits]
    )
    
    @charge = Charge.new(
      :amount     => @amount, 
      :user_id    => current_user.id,
      :package_id => @package.id,
      :folio_id   => @folio.id
    )
    @charge.save
    
    url = Folio.register_keyword(params[:keyword])
    @response = HTTParty.get(url)
    
    redirect_to folio_path(@folio)
    
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to folio_path
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def show
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



