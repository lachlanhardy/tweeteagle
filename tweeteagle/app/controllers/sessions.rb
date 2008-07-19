class Sessions < Application
  
  def new
    render
  end
  
  def openid
    if openid_request? # has the user provided a url (openid_url)
      openid_authenticate(:sreg => ["nickname", "email"]) do |result, identity_url, sreg|
        if result == :successful
          Merb.logger.info "Login with #{identity_url.inspect} successful"
          session[:identity_url] = identity_url 
          
          # find the identity url
          oid = OpenIdentity.first(:identity_url => identity_url)
          if oid.nil?
            # if the id url is nil create it and create the user
            oid  = OpenIdentity.new(:identity_url => identity_url)
            user = User.new
            Merb.logger.info "\n\n\nsreg is #{sreg.inspect}"
            user.name = sreg["nickname"]
            user.email = sreg["email"]
            user.open_identities << oid
            user.save
            redirect(:edit_profile) and return ""
          end
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
