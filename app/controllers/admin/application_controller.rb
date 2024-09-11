class Admin::ApplicationController < ActionController::Base
  before_action :authenticate_user!
  # verify_authorized
  layout "admin/application"
end
