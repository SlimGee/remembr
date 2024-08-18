class NoticeImagesController < ApplicationController
  before_action :set_notice
  def new
  end

  def create
    attachment = @notice.images.attach(notice_image_params[:image])
    puts(attachment)
    if attachment
      render json: @notice
    end
  end

  private

  def set_notice
    @notice = Notice.find(params[:notice_id])
  end

  def notice_image_params
    params.require(:notice_image).permit(:image)
  end
end
