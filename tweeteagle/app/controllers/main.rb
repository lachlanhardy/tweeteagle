class Main < Application
  before :login_required
  
  def index
    render
  end 
  
end