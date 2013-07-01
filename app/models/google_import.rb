class GoogleImport
  attr_accessor :next_url, :secure, :sess, :max_results,
                :json_response, :single_use_token, :user_id
  
  def initialize(attributes = {})
    self.max_results = 1000
    attributes.each_pair do |name, value|
      send("#{name}=", value)
    end
  end
  
  def make_contacts_array
    self.return_google_json
    contacts = self.create_contacts_hash_array
  end
  
  def auth_url
    client = GData::Client::Contacts.new
    authsub_link = client.authsub_url(self.next_url, self.secure, self.sess)
  end
  
  def return_google_json
    client = GData::Client::Contacts.new
    client.authsub_token = self.single_use_token
    @json_response = client.get("http://www.google.com/m8/feeds/contacts/default/full?max-results=#{self.max_results}&alt=json").to_json
  end
  
  def create_session_token
    client = GData::Client::Contacts.new
    client.authsub_token = self.single_use_token
    session_token = client.auth_handler.upgrade()
    self.single_use_token = session_token
    return self.single_use_token
  end
  
  def create_contacts_hash_array
    contacts = []
    hashie = JSON.parse(self.json_response)
    primary_hash = JSON.parse(hashie['body'])
    el_array = primary_hash["feed"]["entry"]
    el_array.each do |element|
      hash = {}
      next if element["gd$email"].nil?
      element["gd$email"].each do |attribute|
        hash['email'] = attribute["address"]
      end
      if element["title"]["$t"] == ""
        hash["name"] = "None"
      else
        hash["name"] = element["title"]["$t"]
      end
      contacts << hash
    end
    return contacts
  end
  
  def invited?(user_email)
    Invitation.invitation_list.collect { |i| i.user_email }.include?(user_email)
  end 
end