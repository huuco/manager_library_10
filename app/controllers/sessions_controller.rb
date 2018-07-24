class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      user.manager? ? redirect_to(admin_root_url) : redirect_to(root_url)
    else
      flash.now[:danger] = t "invalid_email_pass"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
