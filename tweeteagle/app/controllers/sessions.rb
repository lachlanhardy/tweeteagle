class Sessions < Application
  
  def new
    render
  end
  
  def openid
    if openid_request? # has the user provided a url (openid_url)
      openid_authenticate do |result, identity_url|
        if result == :success
          # Find id url and get the user
          # Else create the user and store the id url
            
          # user = User.find_by_openid_url(identity_url)
        end
      end
    end
  end
  
end
