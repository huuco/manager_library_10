class AdminController < ApplicationController
  before_action :loged_in_manager

  private

  def loged_in_manager
    if user_signed_in?
      unless current_user.admin? || current_user.manager?
        redirect_to root_path
      end
    else
      redirect_to new_user_session_path
    end
  end
end
