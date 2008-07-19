require File.join(File.dirname(__FILE__), "..", "spec_helper")

describe User do
  
  describe "attributes" do
    
    before(:each) do
      @user = User.new
    end
    
    it{@user.should respond_to(:fe_request_token)}
    it{@user.should respond_to(:fe_request_token_secret)}
    it{@user.should respond_to(:fe_access_token)}
    it{@user.should respond_to(:fe_access_token_secret)}
    it{@user.should respond_to(:twit_username)}
    it{@user.should respond_to(:twit_password)}  
    it{@user.should respond_to(:activated)}
  end
  
  describe "relationships" do
    it "should have n open_identities"
    
  end
  
end