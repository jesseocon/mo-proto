FactoryGirl.define do 
  factory :user do
    sequence(:email) { |n| "#{n}@gmail.com" }
    name 'jesse ocon'
    password 'foobar'
    password_confirmation 'foobar'
    verified true
  end
  
  factory :album do
    name 'jesse'
    user
  end
  
  factory :invitation do
    album
    user_email 'jesseocon@gmail.com'
  end
  
  # factory :contact do 
  #   
  #   email 'jenesseocon@gmail.com'
  #   name 'Jenesse Ocon'
  #   user
  # end
end