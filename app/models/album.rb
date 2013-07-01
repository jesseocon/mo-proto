class Album < ActiveRecord::Base
  attr_accessible :album_handle, :name, :user_id
  has_many :incoming_messages
  has_many :invitations
  belongs_to :user
  
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  before_create :make_handle
  
  def make_handle
    self.album_handle = "#{self.name}@inbound.folioshine.com"
  end
  
  def send_invitations
    
  end
  
  def invited?
    
  end

end
