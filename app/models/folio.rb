class Folio < ActiveRecord::Base
  attr_accessible :name, :hashtag
  validates :name, :presence => true
  validates :name, :length => { :minimum => 3 }
  validates :name, :length => { :maximum => 24 }
  validates :hashtag, :presence => true
  validates :hashtag, :length => { :minimum => 3 }
  validates :hashtag, :length => { :maximum => 24 }
  validates_uniqueness_of :hashtag
  
  def album_keyword
    
  end
  
  def self.check_availability(hashtag)
    f = Folio.find_by_hashtag(hashtag)
    if f.nil?
      return true
    else
      return false
    end
  end
  
end
