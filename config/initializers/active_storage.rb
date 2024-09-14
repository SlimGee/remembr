Rails.application.config.to_prepare do
  ActiveStorage::DirectUploadsController.class_eval do
    before_action :authenticate_user!
    rate_limit to: 20, within: 20.minutes, by: -> { current_user.id }
  end
end

Rails.application.config.active_storage.resolve_model_to_route = :rails_storage_proxy
