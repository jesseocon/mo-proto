class Package < ActiveRecord::Base
  attr_accessible :name, :photo_qty, :price
  has_many :folios
end
