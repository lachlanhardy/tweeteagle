class OpenIdentity
  include DataMapper::Resource
  
  property :id,  Serial
  property :identity_url, String 
  
  belongs_to :user
  
end