require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

describe Merb::FireEagleHelpers do
  
  include Merb::FireEagleHelpers
  
  before(:each) do
    self.stub!(:logged_in?).and_return(true)
    @user = mock("current_user", :null_object => true)
    self.stub!(:current_user).and_return @user
    @client = mock("client", :null_object => true)
    FireEagle::Client.stub!(:new).and_return(@client)
  end
  
  it "should get the configuration for fire_eagle" do
    config = fire_eagle_config
    config.should be_a_kind_of(Hash)
    config[:consumer_secret].should_not be_nil
    config[:consumer_key].should_not be_nil
  end
  
  it "should use a FireEagleClient" do
    FireEagle::Client.should_receive(:new).with(fire_eagle_config).and_return(@client)
    new_fire_eagle_token!
  end
  
  it "should raise an error if not logged in" do
    stub!(:logged_in?).and_return(false)
    lambda do
      new_fire_eagle_token!
    end.should raise_error
  end
  
  it "should not raise an error if logged in" do
    lambda do
      new_fire_eagle_token!
    end.should_not raise_error
  end
  
  it "should store the request token in the user model"
  it "should store the request token secret in the user model"
  
  it "should return the client object" do
    new_fire_eagle_token!.should == @client
  end
  
end