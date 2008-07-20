require File.join(File.dirname(__FILE__), "..", "spec_helper")

describe User do
  
  before(:each) do
    @user = User.new
  end
  
  describe "attributes" do
    it{@user.should respond_to(:twit_username)}
    it{@user.should respond_to(:twit_password)}  
    it{@user.should respond_to(:activated)}
  end
  
  describe "relationships" do
    it "should have n open_identities" do
      r = User.relationships[:open_identities]
      r.child_model.should == OpenIdentity
      r.options[:max].should == 1.0/0
    end
    
  end
  
  describe "fire eagle integration" do
    before(:each) do
      @user.stub!(:fe_access_token).and_return("TOKEN")
      @user.stub!(:fe_access_token_secret).and_return("SECRET")
      @user.stub!(:fe_request_token).and_return("RTOKEN")
      @user.stub!(:fe_request_token_secret).and_return("RSECRET")
      @user.stub!(:attribute_set)
      @user.stub!(:save)
      @client = mock("client", :null_object => true, :token => "TOKEN", :secret => "SECRET")
      @client.stub!(:request_token).and_return(@client)
      FireEagle::Client.stub!(:new).and_return(@client)
    end
    
    it{@user.should respond_to(:fe_request_token)}
    it{@user.should respond_to(:fe_request_token_secret)}
    it{@user.should respond_to(:fe_access_token)}
    it{@user.should respond_to(:fe_access_token_secret)}
    it{@user.should respond_to(:fire_eagle_setup?)}
    
    
    describe "fire_eagle_setup?" do
      it "should not be setup if fe_access_token is not set" do
        @user.should_receive(:fe_access_token).and_return(nil)
        @user.should_not be_fire_eagle_setup
      end
    
      it "should not be setup if fe_access_token_secret is not set" do
        @user.should_receive(:fe_access_token_secret).and_return(nil)
        @user.should_not be_fire_eagle_setup
      end
    end
    
    describe "fire_eagle_requested?" do
      it "should not be setup if fe_access_token is not set" do
        @user.should_receive(:fe_request_token).and_return(nil)
        @user.should_not be_fire_eagle_requested
      end
    
      it "should not be setup if fe_access_token_secret is not set" do
        @user.should_receive(:fe_request_token_secret).and_return(nil)
        @user.should_not be_fire_eagle_requested
      end
    end
    
    describe "#fire_eagle_request!" do

      it "should use a FireEagleClient" do
        FireEagle::Client.should_receive(:new).with(Merb.config[:fire_eagle]).and_return(@client)
        @user.fire_eagle_request!
      end

      it "should store the request token in the user model" do
        @user.should_receive(:attribute_set).with(:fe_request_token, "TOKEN")
        @user.fire_eagle_request! 
      end

      it "should store the request token secret in the user model" do
        @user.should_receive(:attribute_set).with(:fe_request_token_secret, "SECRET")
        @user.fire_eagle_request!
      end

      it "should save the model" do
        @user.should_receive(:save)
        @user.fire_eagle_request!
      end

      it "should return the client object" do
        @user.fire_eagle_request!.should == @client
      end
    end
        
    describe "fire_eagle_auth_url" do
      it "should return a url from the client" do
        @client.should_receive(:authorization_url).and_return("AUTH_URL")
        @user.fire_eagle_auth_url
      end
      
      it "should setup the request keys if user is not setup" do
        @user.should_receive(:fire_eagle_requested?).and_return(false)
        @user.should_receive(:fire_eagle_request!).and_return(@client)
        @client.should_receive(:authorization_url).and_return("AUTH_URL")
        @user.fire_eagle_auth_url.should == "AUTH_URL"
      end
      
      it "should not setup the request keys if the user is not setup" do
        @user.should_receive(:fire_eagle_requested?).and_return(true)
        @user.should_not_receive(:fire_eagle_request!)
        FireEagle::Client.should_receive(:new).and_return(@client)
        @client.should_receive(:authorization_url).and_return("AUTH_URL")
        @user.fire_eagle_auth_url.should == "AUTH_URL"
      end
    end
  end
  
end