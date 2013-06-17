require 'spec_helper'

describe Album do
  before { @user = User.new(email: 'jesseocon@gmail.com', )}
  before { @album = Album.new(name: jesse, user_id: 7 ) }
  subject { @album }
end
