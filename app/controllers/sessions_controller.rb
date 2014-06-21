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
      flash[:error] = 'Invalid login!'
      redirect_to :back
    end
  end
end
