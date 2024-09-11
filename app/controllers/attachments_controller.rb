class AttachmentsController < ApplicationController
  def destroy
    if attachment = ActiveStorage::Attachment.find_by(id: params[:id])
    else
      attachment = ActiveStorage::Blob.find(params[:id])
    end

    attachment.purge

    render json: {status: :ok}
  end
end
