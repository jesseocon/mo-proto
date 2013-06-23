require 'spec_helper'

describe GoogleImport do
  before { @google_import = GoogleImport.new(
    :next_url => 'http://192.168.1.105:3000/callbacks', 
    :secure => false, 
    :sess => true
  )}
  subject { @google_import }
  SESSION_TRUE = "session=1"
  SECURE_FALSE = "secure=0"
  SESSION_TOKEN = '1/WZTU1zUnzmriHdFJLMe2mWuOXpTd7k71ogcaMtmANXc'
  
  it { should respond_to(:next_url) }
  it { should respond_to(:secure) }
  it { should respond_to(:sess) }
  
  describe "the response from GoogleImport#return_authsub_url" do
    it "should contain the next url in the url" do
      encoded_next_url = CGI::escape(@google_import.next_url)
      @google_import.return_auth_url.should include(encoded_next_url)
    end
    it "should contain session=1 parameter" do
      @google_import.return_auth_url.should include(SESSION_TRUE)
    end
    it "should contain session=1 parameter" do
      @google_import.return_auth_url.should include(SECURE_FALSE)
    end
  end
  
  
end