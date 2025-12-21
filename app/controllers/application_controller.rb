class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to? :html

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern


  def custom_layout
    return "turbo_rails/frame" if turbo_frame_request?

    "application"
  end
end
