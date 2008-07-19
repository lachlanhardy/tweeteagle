require File.join(File.dirname(__FILE__), "..", "spec_helper")

describe OpenIdentity do
  
  describe "properties" do
    before(:all) do
      @oid = OpenIdentity.new
    end
    
    it{@oid.should respond_to(:identity_url)}  
  end
  
  describe "relationships" do
    before(:all) do
      @opid = OpenIdentity.new
    end
    
    it "should belong_to a user" do
      OpenIdentity.relationships[:user].parent_model.should == User
    end
  end
  
end