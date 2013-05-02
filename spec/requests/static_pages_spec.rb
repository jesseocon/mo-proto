require 'spec_helper'

describe "StaticPages" do
  subject { page }
  describe "Home page" do
    before { visit root_path }
    it { should have_link('Log in', href: signup_path) }
    it { should have_link('Sign up!', href: signup_path) }
    it { should have_selector('title', text: 'Folioshine | Home') }
  end
end
