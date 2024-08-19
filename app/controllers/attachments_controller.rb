class AttachmentsController < ApplicationController
  def destroy
    attachment = ActiveStorage::Attachment.find(params[:id])
    attachment.purge

    render json: {status: :ok}
  end
end
