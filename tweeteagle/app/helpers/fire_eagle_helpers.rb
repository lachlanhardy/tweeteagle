module Merb
  module FireEagleHelpers
    
    def new_fire_eagle_token!
      raise "Need to be logged in" unless logged_in?
      client = FireEagle::Client.new(fire_eagle_config)
      client
    end
    
    
    private
    def fire_eagle_config
      Merb.config[:fire_eagle]
    end
  end
end