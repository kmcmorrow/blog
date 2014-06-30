class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      flash[:notice] = 'Logged in.'
      redirect_to :root
    else
      if user
        flash[:error] = 'Invalid password!'
      else
        flash[:error] = "User doesn't exist"
      end
      redirect_to :back
    end
  end

  def destroy
    sign_out
    flash[:notice] = 'Logged out'
    redirect_to root_path
  end
end
