class Payments::CallbackController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    # Get the transaction reference number from the request parameters

    transaction = Transaction.find_by!(reference_number: params[:referenceNumber])

    # Update the transaction status based on the request parameters
    transaction.update({
      date_of_transaction: params[:dateOfTransaction],
      application_id: params[:applicationId],
      application_name: params[:applicationName],
      amount: params[:amountDetails][:amount],
      currency_code: params[:amountDetails][:currencyCode],
      default_currency_amount: params[:amountDetails][:defaultCurrencyAmount],
      default_currency_code: params[:amountDetails][:defaultCurrencyCode],
      transaction_service_fee: params[:amountDetails][:transactionServiceFee],
      customer_payable_amount: params[:amountDetails][:customerPayableAmount],
      total_transaction_amount: params[:amountDetails][:totalTransactionAmount],
      merchant_amount: params[:amountDetails][:merchantAmount],
      formatted_merchant_amount: params[:amountDetails][:formattedMerchantAmount],
      reason_for_payment: params[:reasonForPayment],
      transaction_status: params[:transactionStatus],
      transaction_status_code: params[:transactionStatusCode],
      transaction_status_description: params[:transactionStatusDescription],
      result_url: params[:resultUrl],
      return_url: params[:returnUrl],
      poll_url: params[:pollUrl],
      transaction_metadata: params[:transactionMetadata]
    })

    transaction.payment_intent.update status: transaction.transaction_status

    if transaction.transaction_status == "SUCCESS"
      transaction.payment_intent.payable.update(
        successful_payment_intent_id: transaction.payment_intent.id,
        payment_successful: true,
        published_at: Time.zone.now
      )
    end
  end
end
