class Folio < ActiveRecord::Base
  attr_accessible :name, :keyword
  attr_accessor :stripe_token
  belongs_to :package
  belongs_to :user
  has_many :charges
  
  validates :name, :presence => true
  validates :name, :length => { :minimum => 3 }
  validates :name, :length => { :maximum => 24 }
  validates :keyword, :presence => true
  validates :keyword, :length => { :minimum => 3 }
  validates :keyword, :length => { :maximum => 24 }
  #validates_uniqueness_of :hashtag
  
  
  BASE_URL = "https://api.mogreet.com/cm/keyword."
  CAMPAIGN_ID = "&campaign_id=29701"
  CLIENT_ID = "?client_id=1383"
  FORMAT = "&format=json"
  TOKEN = "&token=dcb7872095eb4650c3818088062bbaa6"
  
  def update_stripe(user_id, package_price)
    @user ||= User.find(user_id)
    @amount ||= (package.price * 100).to_i
    if @user.strip_id.nil?
      if !stripe_token.present?
        raise "We're doing something wrong -- this isn't supposed to happen"
      end
      
      customer = Stripe::Customer.create(
        :email        => @user.email,
        :description  => "test description", #replace this
        :card         => stripe_token
      )
      
      charge = Stripe::Charge.create(
        :customer     => customer.id,
        :amount       => amount,
        :description  => "Rails Stripe Customer",
        :currency     => 'usd' 
      )
      
      @user.last_4_digits = customer.active_card.last4
      @user.save
      
    end
  end
  
  def self.check_availability(keyword)
    kw_param = "&keyword=#{keyword}"
    method = 'check'
    final_url = "#{BASE_URL}#{method}#{CLIENT_ID}#{TOKEN}#{kw_param}#{FORMAT}"
  end
  
  def self.register_keyword(keyword)
    kw_param = "&keyword=#{keyword}"
    method = 'add'
    final_url = "#{BASE_URL}#{method}#{CLIENT_ID}#{TOKEN}#{CAMPAIGN_ID}#{kw_param}#{FORMAT}"
  end
  
  def self.deregister_keyword(keyword)
    kw_param = "&keyword=#{keyword}"
    method = 'remove'
    final_url = "#{BASE_URL}#{method}#{CLIENT_ID}#{TOKEN}#{CAMPAIGN_ID}#{kw_param}#{FORMAT}"
  end
  
  def update_user
    
  end
  
  def update_charge
    
  end
  
  def update_folio
    
  end
    
end







