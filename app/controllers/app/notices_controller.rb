class App::NoticesController < ApplicationController
  def index
    # @notices = Notice.order(created_at: :desc).page(params[:page]).per(10)
    @q = Notice.ransack(params[:q])
    @notices = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
  end
end
