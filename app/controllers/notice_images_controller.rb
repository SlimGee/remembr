class NoticeImagesController < ApplicationController
  before_action :set_notice
  def new
  end

  def create
    @notice.images.attach(notice_image_params[:images])
    if @notice.images.attached?
      redirect_to notice_payment_path(@notice)
    else
      redirect_to new_notice_notice_images_path(@notice), alert: "Please select at least one image."
      # render json: @notice.images.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def set_notice
    @notice = Notice.friendly.find(params[:notice_id])
  end

  def notice_image_params
    params.require(:notice).permit(images: [])
  end
end
