require 'spec_helper'

describe Contact do
  before { @contact = Contact.create(name: 'Jesse Ocon', email: 'jesseocon@gmail.com', user_id: 1) }
  subject { @contact }
  
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:user_id) } 
  
  describe "when email is blank" do 
    before do 
      @contact.email = " " 
    end
    
    it { should_not be_valid }
  end
  
  describe "when a user has two contacts with the same email" do
    before { @contact2 = Contact.create(name: 'Jesse Ocon', email: 'jesseocon@gmail.com', user_id: 1) }
    subject { @contact2 }
    it { should_not be_valid }
  end
  
  describe "when a user has two contacts with the same email but one is uppercase" do
    before { @contact2 = Contact.create(name: 'Jesse Ocon', email: @contact.email.upcase, user_id: 1) }
    subject { @contact2 }
    it { should_not be_valid }
  end
  
  describe "when user_id is not present" do
    before do
      @contact.user_id = nil
    end
    it { should_not be_valid }
  end
  
  describe "creating multiple contacts with an array of hashes of valid unique email addresses" do 
    it "should create multiple invitations from an array of valid contact hashes" do
      user_id = 2
      contacts = [
          {"user_id" => user_id, "name" => "Jesse Ocon", "email" => "jesseocon@gmail.com"},
          {"user_id" => user_id, "name" => "Jesse Ocon1", "email" => "jesseocon@gmail1.com"},
          {"user_id" => user_id, "name" => "Jesse Ocon2", "email" => "jesseocon@gmail2.com"},
          {"user_id" => user_id, "name" => "Jesse Ocon3", "email" => "jesseocon@gmail3.com"},
        ]
      
      Contact.create_multiple(contacts)
      Contact.where(user_id: user_id).count.should == contacts.length
    end
  end
  
end


