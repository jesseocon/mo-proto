require 'spec_helper'

describe Invitation do
  before { @user = FactoryGirl.create(:user) }
  before { @invitation = FactoryGirl.create(:invitation, user_email: @user.email) }
  subject { @invitation }
  
  it { should respond_to(:album_id) }
  it { should respond_to(:user_email) }
  
  describe "invitation without email address" do
    before { @invitation.user_email = nil }
    it { should_not be_valid }
  end
  
  describe "invitation with blank email address" do
    before { @invitation.user_email = ' ' }
    it { should_not be_valid }
  end
  
  describe "invitation with that does not belong to an album" do
    before { @invitation.album_id = nil }
    it { should_not be_valid }
  end
  
  describe "parsing emails separated by commas" do
    email = "a@b.com, b@b.com, c@b.com"
    emails = ['a@b.com', 'b@b.com', 'c@b.com']
    it "should return an array of emails" do
      Invitation.parse_emails(email).should == emails
    end 
  end
  
  describe "parsing emails separated by semicolons" do 
    email = "a@b.com; b@b.com; c@b.com"
    emails = ['a@b.com', 'b@b.com', 'c@b.com']
    it "should return an array of emails" do 
      Invitation.parse_emails(email).should == emails
    end
  end
  
  describe "parsing emails separated tabs commas and semicolons" do 
    it "should return an array of emails" do 
      email = "a@b.com  b@b.com; c@b.com, d@b.com"
      emails = ['a@b.com', 'b@b.com', 'c@b.com', 'd@b.com']
      Invitation.parse_emails(email).should == emails
    end
  end
  
  describe "creating multiple invitations with valid unique email addresses" do 
    emails = ['a@b.com', 'b@b.com', 'c@b.com', 'd@b.com']
    it "should create multiple invitations from an array of email addresses" do
      album_id = 199
      Invitation.create_multiple(album_id, emails)
      Invitation.where(album_id: album_id).count.should == emails.length
    end
  end
  
  describe "creating multiple invitations with one non-unique address" do
    emails = ['a@b.com', 'a@b.com', 'b@b.com', 'c@b.com', 'd@b.com']
    it "should create one record less than than the email array length" do
      album_id = 200
      Invitation.create_multiple(album_id, emails)
      Invitation.where(album_id: album_id).count.should == (emails.length - 1)
    end
  end
  
  describe "creating multiple invitations with 5 email addresses that are not valid" do
    emails = [
      'a@b.com', 
      'b@b.com', 
      'c@b.com', 
      'd@b.com', 
      'user@foo,com', 
      'user_at_foo.org', 
      'example.user@foo.', 
      'foo@bar_baz.com', 
      '@foo@bar+baz.com'
    ]
    it "should create 5 less records than the length of the emails array" do
      album_id = 201
      Invitation.create_multiple(album_id, emails)
      Invitation.where(album_id: album_id).count.should == (emails.length - 5)
    end
  end
    
end
