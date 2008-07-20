class User
  include DataMapper::Resource
  
  property :id,                       Serial
  property :fe_request_token,         String, :length => 255
  property :fe_request_token_secret,  String, :length => 255
  property :fe_access_token,          String, :length => 255
  property :fe_access_token_secret,   String, :length => 255
  property :twit_username,            String, :length => 255
  property :twit_password,            String, :length => 255
  property :activated,                Boolean, :default => false
  
  property :email,                    String, :length => 255
  property :name,                     String, :length => 255
  
  has n, :open_identities


  # overwrites the fire eagle tokens presently in the user object
  def fire_eagle_request!
    client = FireEagle::Client.new(fire_eagle_config)
    attribute_set(:fe_request_token,        client.request_token.token)
    attribute_set(:fe_request_token_secret, client.request_token.secret)
    save
    client
  end
  
  def fire_eagle_auth_url
    client = if fire_eagle_requested?
      FireEagle::Client.new(fire_eagle_config.merge(:request_token        => fe_request_token, 
                                                    :request_token_secret => fe_request_token_secret ))
    else
      fire_eagle_request!
    end
    client.authorization_url    
  end

  def fire_eagle_setup?
    !!(fe_access_token && fe_access_token_secret) 
  end
  
  def fire_eagle_requested?
    !!(fe_request_token && fe_request_token_secret) 
  end
  
  private 
  def fire_eagle_config
    Merb.config[:fire_eagle]
  end
end