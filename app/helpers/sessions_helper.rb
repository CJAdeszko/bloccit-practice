module SessionsHelper

  def create_session(user)
    session[:user_id] = user.id #session is an object provided by Rails to track the state of a User.
  end

  def destroy_session(user)
    session[:user_id] = nil
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

end
