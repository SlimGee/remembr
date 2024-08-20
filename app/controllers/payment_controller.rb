class PaymentController < ApplicationController
  before_action :set_notice
  def create
    pesepay = initialize_pesepay(notices_url)

    response = pesepay.initiate_transaction(
      pesepay.create_transaction(5, "USD", "Listing notices on Remembr", SecureRandom.alphanumeric(16))
    )

    transaction = Transaction.create reference_number: response.referenceNumber

    @notice.payment_intents.create transfer: transaction, amount: 5, user: current_user

    if response.success
      redirect_to response.redirectUrl, allow_other_host: true
    else
      redirect_back notices_path
    end
  end

  private

  def set_notice
    @notice = Notice.find(params[:notice_id])
  end

  def initialize_pesepay(return_url)
    pesepay = Pesepay::Pesepay.new(
      Rails.application.credentials.pesepay_integration_key,
      Rails.application.credentials.pesepay_encryption_key
    )
    pesepay.result_url = "https://1e62-102-128-79-94.ngrok-free.app#{payments_callback_path}"
    pesepay.return_url = return_url

    pesepay
  end
end
