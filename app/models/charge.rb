class Charge < ActiveRecord::Base
  attr_accessible :amount, :folio_id, :user_id, :package_id
  attr_accessor :stripe_token
  belongs_to :user
  belongs_to :folio
  
end
