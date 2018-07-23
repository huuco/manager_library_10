class Admin::UsersController < ApplicationController
  def index
    if params[:role].nil?
      @users = User.all.page(params[:page]).per Settings.pages.per_user
    else
      @users = User.get_by_role(params[:role]).page(params[:page])
        .per Settings.pages.per_user
    end
  end
end
