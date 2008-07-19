class User
  include DataMapper::Resource
  
  property :id,                       Serial
  property :fe_request_token,         String, :length => 255
  property :fe_request_token_secret,  String, :length => 255
  property :fe_access_token,          String, :length => 255
  property :fe_access_token_secret,   String, :length => 255
  property :twit_username,            String, :length => 255
  property :twit_password,            String, :length => 255

end