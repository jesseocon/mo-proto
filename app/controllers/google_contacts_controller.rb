class GoogleContactsController < ApplicationController
  def get_client
    @google_import = GoogleImport.new(next_url: 'http://192.168.1.101:3000/callbacks', secure: false, sess: true)
    redirect_to @google_import.auth_url
  end
  
  def callbacks
    @google_import = GoogleImport.new(single_use_token: params[:token], max_results: 1000, user_id: current_user.id)
    @contacts = @google_import.make_contacts_array.sort_by { |hsh| hsh["name"] }
  end
  
  def get_contacts
    puts "CURRENT_USER_ID************************#{current_user.id rescue "1 million"}"
    puts "SESSION TOKEN***********#{session[:token]}" 
  end
end
