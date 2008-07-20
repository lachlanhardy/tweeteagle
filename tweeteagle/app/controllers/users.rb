class Users < Application
  before :login_required
  
  def edit
    render
  end

  def update(user)
    current_user.update_attributes(user)
    current_user.save
    redirect url(:home)
  end
  
  def activate_fire_eagle
    current_user.fire_eagle_activate!
    redirect url(:home)
  end

end
