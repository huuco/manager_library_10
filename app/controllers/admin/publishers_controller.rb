class Admin::PublishersController < AdminController
  before_action :get_publisher, except: %i(index new create)

  def index
    @publishers = Publisher.select_publishers.search params[:search]
    respond_to do |format|
      format.html
      format.js
    end
    @publishers = @publishers.order(created_at: :desc)
                             .page(params[:page]).per Settings.pages.per_ctg
  end

  def new
    @publisher = Publisher.new
  end

  def create
    @publisher = Publisher.new publisher_params
    if @publisher.save
      flash[:success] = t ".add_success" + " " + @publisher.name
      redirect_to admin_publisher_path(@publisher)
    else
      flash[:error] = t ".add_fail"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @publisher.update_attributes publisher_params
      flash[:success] = t ".update_success"
      redirect_to admin_publisher_path
    else
      render :edit
    end
  end

  def destroy
    unless @publisher.books.any?
      if @publisher.destroy
        flash[:success] = t ".delete_success"
      else
        flash[:danger] = t ".delete_fail"
      end
    else
      flash[:danger] = t ".pub_has_books"
    end
    redirect_to admin_publishers_path
  end
  
  private

  def publisher_params
    params.require(:publisher).permit :name, :address, :phone, :info
  end

  def get_publisher
    @publisher = Publisher.find_by id: params[:id]
    return if @publisher
      flash[:danger] = t "not_found" + params[:id]
      redirect_to admin_publishers_path
  end
end
