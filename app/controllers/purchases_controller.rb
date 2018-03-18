class PurchasesController < ApplicationController
  before_action :find_purchase, only: [:edit, :update, :destroy]
  before_action :load_users, only: [:new, :edit]

  def index
    date = params[:month] ? "01/#{params[:month]}".to_date : Time.zone.today
    @purchases = Purchase.includes(:user).recent.in_month date
  end

  def new
    @purchase = Purchase.new
  end

  def create
    @purchase = Purchase.new purchase_params

    if @purchase.save
      flash[:success] = "Thêm mới thành công"
      redirect_to purchases_path
    else
      flash.now[:warning] = "Không thể thêm mới"
      load_users
      render :new
    end
  end

  def edit
  end

  def update
    if @purchase.update_attributes purchase_params
      flash[:success] = "Cập nhật thành công"
      redirect_to purchases_path
    else
      flash.now[:warning] = "Không thể cập nhật"
      load_users
      render :edit
    end
  end

  def destroy
    if @purchase.destroy
      flash[:success] = "Xóa thành công"
    else
      flash[:warning] = "Không thể xóa"
    end
    redirect_to purchases_path
  end

  private

  def purchase_params
    params.require(:purchase).permit :user_id, :date, :amount, :note
  end

  def find_purchase
    @purchase = Purchase.find_by id: params[:id]

    return if @purchase
    flash[:warning] = "Không tìm thấy khoản chi"
    redirect_to root_path
  end

  def load_users
    @users = User.pluck :name, :id
  end
end
