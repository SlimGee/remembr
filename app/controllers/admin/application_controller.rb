class Admin::ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :authorize!
  verify_authorized
  layout "admin/application"

  def implicit_authorization_target
    # If you don't pass the target, it will be guessed
    # based on the controller name.
    # See https://actionpolicy.evilmartians.io/#/implicit_target
    super || controller_name.classify.to_sym
  end

  def authorization_strict_namespace
    true
  end
end
