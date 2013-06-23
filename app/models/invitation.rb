class Invitation < ActiveRecord::Base
  attr_accessible :album_id, :user_email
  belongs_to :album
  belongs_to :user
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates_presence_of :album_id, :user_email
  validates :user_email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates_uniqueness_of :user_email, :scope => :album_id
  
  def self.parse_emails(emails)
    return emails.split(/[\s,;]+\s/)
  end
  
  
  def self.create_multiple(album_id, emails)
    emails.each do |email|
      invitation = Invitation.create(album_id: album_id, user_email: email)
      if invitation.valid?
        invitation.save!
      else
      end
    end
  end
  
  def self.send_invitations(album_id)
    invitations = Invitations.where(album_id: album_id)
    invitations.each do |invitation|
      invitation.send
    end
  end
  
end
