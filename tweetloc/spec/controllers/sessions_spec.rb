require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

describe Signups, "index action" do
  before(:each) do
    dispatch_to(Signups, :index)
  end
end