module App
  class Pesepay < Pesepay::Pesepay
    def initialize
      super(Rails.application.credentials.pesepay_integration_key, Rails.application.credentials.pesepay_encryption_key)
    end
  end
end
