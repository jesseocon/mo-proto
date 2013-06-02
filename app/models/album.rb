class Album < ActiveRecord::Base
  attr_accessible :album_handle, :name, :user_id
  has_many :incoming_messages
  
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  before_create :make_handle
  
  def make_handle
    self.album_handle = "#{self.name}@inbound.folioshine.com"
  end
end
