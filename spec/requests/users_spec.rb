require 'spec_helper'

describe "User pages" do
  describe "Signup page" do 
    it "should have an element h4 'Sign in" do
      visit signup_path
      page.should have_content('Sign in')
    end
    it "should have the title 'Sign up/Sign in'" do
      visit signup_path
      page.should have_selector('title', :text => 'Folioshine | Sign up')
    end
  end
end
