class Star < ActiveRecord::Base
  attr_accessible :incoming_message_id, :user_id
end
