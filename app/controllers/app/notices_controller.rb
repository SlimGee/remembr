class App::NoticesController < ApplicationController
  def index
    # @notices = Notice.order(created_at: :desc).page(params[:page]).per(10)
    @q = Notice.published.ransack(params[:q])
    @notices = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @notice = Notice.friendly.find(params[:id])
    raise ActiveRecord::RecordNotFound unless @notice.published?
  end
end
