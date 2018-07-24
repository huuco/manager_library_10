class Admin::UsersController < AdminController
  def index
    if params[:role]
      @users = User.select_users.get_by_role(params[:role])
    else
      @users = User.select_users
    end
    @users = @users.order(created_at: :desc)
      .page(params[:page]).per Settings.pages.per_user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t ".add_success" + " " + @user.name
      redirect_to admin_user_path(@user)
    else
      flash[:error] = t ".add_fail"
      render :new
    end
  end

  def show
    return if @user = User.find_by id: params[:id]
      flash[:danger] = t "not_found" + params[:id]
      redirect_to admin_users_path
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
