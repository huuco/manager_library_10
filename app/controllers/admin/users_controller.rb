class Admin::UsersController < AdminController
  def index
    @users = if params[:search].present?
        User.select_users.get_by_name_email params[:search]
      else
        User.select_users
      end
    @users = @users.get_by_role params[:role] if params[:role].present?

    respond_to do |format|
      format.html
      format.js
      format.csv {send_data @users.to_csv, filename: "list_user.csv"}
      format.xls
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
    @user = User.find_by id: params[:id]
    return if @user
      flash[:danger] = t "not_found" + params[:id]
      redirect_to admin_users_path
  end

  def update
    if current_user.admin?
      @user = User.find_by id: params[:id]
      if @user.update_attributes role: params[:role]
        respond_to do |format|
          format.html do
            flash[:success] = t "assigned"
            redirect_to @user
          end
          format.js
        end
      end
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
      :password_confirmation)
  end
end
