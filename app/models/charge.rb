class Charge < ActiveRecord::Base
  attr_accessible :amount, :folio_id, :user_id, :package_id, 
                  :stripe_charge_id, :stripe_token, :limit
  attr_accessor :stripe_token
  belongs_to :user
  belongs_to :folio
  before_save :charge_card
  
  def charge_card
    charge = Stripe::Charge.create(
      :card         => self.stripe_token,
      :amount       => self.amount,
      :description  => "Rails Stripe Customer",
      :currency     => 'usd' 
    )
    self.stripe_charge_id = charge.id
  end
  
end
