class SummariesController < ApplicationController
  before_action :find_summary, only: [:update, :destroy]

  def index
    @summaries = Summary.includes(summary_details: :user).recent
  end

  def create
    created, msg = SummaryServices::CreateSummary.new.perform

    if created
      flash[:success] = "Thêm mới thành công"
    else
      flash[:warning] = msg || "Không thể thêm mới"
    end
    redirect_to summaries_path
  end

  def update
    if @summary.completed!
      flash[:success] = "Cập nhật thành công"
    else
      flash[:warning] = "Không thể cập nhật"
    end
    redirect_to summaries_path
  end

  def destroy
    if @summary.not_completed? && @summary.destroy
      flash[:success] = "Xóa thành công"
    else
      flash[:warning] = "Không thể xóa"
    end
    redirect_to summaries_path
  end

  private

  def find_summary
    @summary = Summary.find_by id: params[:id]

    return if @summary
    flash[:warning] = "Không tìm thấy bản ghi"
    redirect_to root_path
  end
end
