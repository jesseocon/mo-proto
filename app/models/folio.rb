class Folio < ActiveRecord::Base
  attr_accessible :name, :keyword, :stripe_token, :package_price, 
                  :keyword_response, :charge_id, :user_id, :limit
  attr_accessor :stripe_token, :package_price, :keyword_response,
                :charge_id, :limit
  
  belongs_to :package
  belongs_to :user
  has_many :charges
  
  before_validation :set_keyword_purchase_response
  
  validates :name,          :presence   => true
  validates :name,          :length     => { :minimum => 3 }
  validates :name,          :length     => { :maximum => 24 }
  validates :keyword,       :presence   => true
  validates :keyword,       :length     => { :minimum => 3 }
  validates :keyword,       :length     => { :maximum => 24 }
  validates :package_price, :presence => true
  validate  :keyword_was_purchased?
  after_save :charge_card, :update_charge, :on => :create
  
  
  BASE_URL = "https://api.mogreet.com/cm/keyword."
  CAMPAIGN_ID = "&campaign_id=29701"
  CLIENT_ID = "?client_id=1383"
  FORMAT = "&format=json"
  TOKEN = "&token=dcb7872095eb4650c3818088062bbaa6"
  
  def charge_card
    charge = Stripe::Charge.create(
      :card         => self.stripe_token,
      :amount       => self.package_price,
      :description  => "Rails Stripe Customer",
      :currency     => 'usd' 
    )
    puts "***************CHARGE#{charge}"
    self.charge_id = charge.id
  end
  
  def self.check_availability(keyword)
    kw_param = "&keyword=#{keyword}"
    method = 'check'
    final_url = "#{BASE_URL}#{method}#{CLIENT_ID}"\
                "#{TOKEN}#{kw_param}#{FORMAT}"
  end
  
  def self.register_keyword(keyword)
    kw_param = "&keyword=#{keyword}"
    method = 'add'
    final_url = "#{BASE_URL}#{method}#{CLIENT_ID}"\
                "#{TOKEN}#{CAMPAIGN_ID}#{kw_param}#{FORMAT}"
  end
  
  def self.deregister_keyword(keyword)
    kw_param = "&keyword=#{keyword}"
    method = 'remove'
    final_url = "#{BASE_URL}#{method}#{CLIENT_ID}"\
                "#{TOKEN}#{CAMPAIGN_ID}#{kw_param}#{FORMAT}"
  end
  
  def set_keyword_purchase_response
    url = Folio.register_keyword(self.keyword)
    response = HTTParty.get(url)
    self.keyword_response = response["response"]["status"]
  end
  
  def keyword_was_purchased?
    response = self.keyword_response == 'success'
    if response == false
      errors.add(:base, "There was a problem purchasing the keyword")
    end
  end
  
  def update_user
    
  end
  
  def update_charge
    db_charge = self.charges.new(
      :amount           => self.package_price,
      :stripe_charge_id => self.charge_id,
      :user_id          => self.user_id,
      :limit            => self.limit
    )
    db_charge.save!
  end
  
  def limit
    limit = 0
    self.charges.collect { |c| limit += c.limit }
    return limit
  end
  
  def total_charges
    total_charges = 0
    self.charges.collect { |c| total_charges += c.amount }
    total = total_charges.to_f / 100
    return total
  end
    
end


