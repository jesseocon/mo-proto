class AddIndexStripeChargeIdToCharges < ActiveRecord::Migration
  def change
    add_index :charges, :stripe_charge_id, :unique => true
  end
end
