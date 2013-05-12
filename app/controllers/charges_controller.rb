class ChargesController < ApplicationController
  layout 'charges'
  def new
  end
  
  def create
    @user = current_user
    @package = Package.find(params[:package_id])
    @amount = (@package.price * 100).to_i
    
    
    customer = Stripe::Customer.create(
      :email    => @user.email,
      :card     => params[:stripe_token]
    )
    
    charge = Stripe::Charge.create(
      :customer     => customer.id,
      :amount       => @amount,
      :description  => 'Rails Stripe customer',
      :currency     => 'usd'
    )
    
    @charge = Charge.new(amount: @amount, user_id: current_user.id)
    @charge.save
    @user.update_attributes(
      stripe_id: customer.id, 
      last_4_digits: params[:last_4_digits]
    )
    
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end
end
