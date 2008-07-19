require File.join(File.dirname(__FILE__), "..", "spec_helper")

describe OpenIdentity do
  
  describe "properties" do
    before(:all) do
      @oid = OpenIdentity.new
    end
    
    it{@oid.should respond_to(:url)}  
  end
  
end