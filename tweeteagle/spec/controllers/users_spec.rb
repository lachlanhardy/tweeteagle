require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

describe Users do
  
  before(:each) do
    User.auto_migrate!
    
    @user = User.new
    @user.save
    @user.stub!(:fire_eagle_auth_url).and_return(:fire_eagle_auth_url)
    @user.stub!(:new_record?).and_return(false)
    @user.stub!(:id).and_return(2)
    @user.stub!(:to_param).and_return(2)
  end
  
  describe "edit" do
    
    before(:each) do
      @body = dispatch_to(Users, :edit) do |c|
        c.stub!(:current_user).and_return(@user)
      end.body      
    end   
    
  end  
  
  describe "update" do
  end  
end