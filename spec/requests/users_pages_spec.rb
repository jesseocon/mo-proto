require 'spec_helper'

describe "User pages" do
  before do
    @user = User.create!(
    :email => 'jesseocon@gmail.com', 
    :password => 'foobar', 
    :password_confirmation => 'foobar', 
    :name => 'Jesse Ocon',
    :verified => true
    )
  end
  subject { page }
  describe "Signup page" do
    before { visit signup_path }
    it { should have_selector('h4', text: 'Sign in') }
    it { should have_selector('title', text: 'Folioshine | Sign up') } 
  end
  
  describe "User Account Page" do 
    before do 
      visit signup_path
      fill_in('email', :with => @user.email)
      fill_in('password', :with => @user.password)
      click_button('sign-in-submit') 
    end
    
    before do 
      visit user_path(@user)
    end
    before { save_and_open_page }
    it { should have_selector('h2', text: @user.name) }
    
  end
end
