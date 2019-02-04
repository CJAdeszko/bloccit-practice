class SessionsController < ApplicationController
  def new
  end


  def create
    user = User.find_by(email: params[:session][:email].downcase) #search for user specified by email in params hash

    if user && user.authenticate(params[:session][:password])
      create_session(user)
      flash[:notice] = "Welcome, #{user.name}"
      redirect_to root_path
    else
      flash.now[:alert] = "Invalid email/password combination."
      render :new
    end
  end


  def destroy
    destroy_session(current_user)
    flash[:notice] = "Signed out successfully."
    redirect_to root_path
  end

end
