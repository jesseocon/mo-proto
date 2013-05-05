class Folio < ActiveRecord::Base
  attr_accessible :name, :hashtag
  validates :name, :presence => true
  validates :name, :length => { :minimum => 3 }
  validates :name, :length => { :maximum => 24 }
  validates :hashtag, :presence => true
  validates :hashtag, :length => { :minimum => 3 }
  validates :hashtag, :length => { :maximum => 24 }
  validates_uniqueness_of :hashtag
  
  BASE_URL = "https://api.mogreet.com/cm/keyword."
  CAMPAIGN_ID = "&campaign_id=29701"
  CLIENT_ID = "?client_id=1383"
  FORMAT = "&format=json"
  TOKEN = "&token=dcb7872095eb4650c3818088062bbaa6"
  
  
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
  
end
