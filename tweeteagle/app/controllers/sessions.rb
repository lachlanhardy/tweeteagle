class Sessions < Application
  
  def new
    render
  end
  
  def openid
    if openid_request? # has the user provided a url (openid_url)
      openid_authenticate do |result, identity_url|
        if result == :successful
          Merb.logger.info "Login with #{identity_url} successful"
          
          # find the identity url
          oid = OpenIdentity.get(:identity_url => identity_url)
          
          # if the id url is nil create it and create the user
            
          # user = User.find_by_openid_url(identity_url)
          redirect url(:home)
        else
          Merb.logger.info "Twas Not Successful"
          redirect url(:login)
        end
      end
    else
      redirect url(:login)
    end
  end
  
end
