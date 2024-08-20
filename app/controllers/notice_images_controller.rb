class NoticeImagesController < ApplicationController
  before_action :set_notice
  def new
  end

  def create
    @notice.images.attach(notice_image_params[:image])
    if @notice.images.attached?
      render json: @notice.images.last
    else
      render json: @notice.images.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def set_notice
    @notice = Notice.friendly.find(params[:notice_id])
  end

  def notice_image_params
    params.require(:notice_image).permit(:image)
  end
end
