module Merb
  module UserHelpers
    class NotLoggedIn < Merb::Controller::Unauthorized; end
    
    def logged_in?
      !!current_user
    end
    
    def current_user
      @current_user ||= (login_from_session || false)
    end
    
    def current_user=(user)
      session[:identity_url] =  (!user || !user.kind_of?(User)) ? nil : user.open_identities.first.identity_url
      @current_user = user
    end
    
    def login_required
      current_user || throw(:halt, :access_denied)
    end
    
    def access_denied
      session[:return_to] = request.uri
      redirect url(:login)
     end
    
    private
    def login_from_session
      self.current_user = User.first(User.open_identities.identity_url => session[:identity_url]) if session[:identity_url]
    end
  end
end