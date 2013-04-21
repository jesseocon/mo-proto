class Message < ActiveRecord::Base
  attr_accessible :campaign_id, :msisdn, :carrier, :message, :image_url
  
end
