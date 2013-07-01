class Contact < ActiveRecord::Base
  attr_accessible :name, :email, :user_id
  validates :email, presence: true
  validates :user_id, presence: true
  validates :email, :uniqueness => { scope: :user_id, case_sensitive: false }
  
  belongs_to :user
  
  def self.create_multiple(contacts)
    contacts.each do |hash|
      contact = Contact.create(hash)
      #contact = Contact.create(user_id: hash["user_id"], name: hash["name"], email: hash["email"])
      if contact.valid?
        contact.save!
      else
      end
    end
  end
  
  def invited?(user_email)
    Invitation.invitation_list.collect { |i| i.user_email }.include?(user_email)
  end
end
