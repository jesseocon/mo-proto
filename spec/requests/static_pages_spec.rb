require 'spec_helper'

describe "StaticPages" do
  describe "Home page" do
    it "should have the content 'Sign up!'" do
      visit root_path
      page.should have_link('Sign up!', href: signup_path)
    end
    it "should have the link 'Log in'" do
      visit root_path
      page.should have_link('Log in', href: signup_path)
    end
    it "should have the title 'Home'" do
      visit root_path
      page.should have_selector('title', :text => "Folioshine | Home")
    end
  end
end
