class Message < ActiveRecord::Base
  attr_accessible :test, :params_hash
  serialize :params_hash, JSON
end
