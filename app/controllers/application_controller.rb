class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  layout :which_layout

  def which_layout
    devise_controller? ? "auth" : "application"
  end
end
