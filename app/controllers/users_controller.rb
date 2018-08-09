class UsersController < ApplicationController
  def show
    @user = User.find_by id: params[:id]
    @borrows = @user.borrows.page(params[:page]).per Settings.pages.per_ctg
  end
end
