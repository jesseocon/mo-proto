require 'spec_helper'

describe "User pages" do
  subject { page }
  describe "Signup page" do
    before { visit signup_path }
    it { should have_selector('h4', text: 'Sign in') }
    it { should have_selector('title', text: 'Folioshine | Sign up') } 
  end
end
