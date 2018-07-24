class AdminController < ApplicationController
  before_action :loged_in_admin

  def loged_in_admin
    if logged_in?
      redirect_to root_url if current_user.role == 0
    else
      redirect_to root_url
    end
  end
end
