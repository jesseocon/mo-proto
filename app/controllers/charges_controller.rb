class ChargesController < ApplicationController
  layout 'charges'
  def new
    @packages = Package.all
  end
  
  def create
    @user = current_user
    @package = Package.find(params[:package][:id])
    @amount = (@package.price * 100).to_i
    @folio = Folio.find(params[:folio_id])
    @charge = @folio.charges.new(
      :amount       => @amount,
      :user_id      => @user.id,
      :limit        => @package.photo_qty,
      :stripe_token => params[:stripe_token]
    )
    if @charge.save
      redirect_to folio_path(@folio)
    else
      render :show
    end
    
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end
end
