# frozen_string_literal: true
# typed: true

class ApplicationController < ActionController::Base
  before_action :set_project
  before_action :check_and_authenticate_user, unless: :devise_controller?
  before_action :authenticate_user!, unless: :devise_controller?
  self.responder = ApplicationResponder
  respond_to? :html

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def custom_layout
    "application"
  end

  private
    def set_project
      @project_name = ENV.fetch("PROJECT_NAME") { "project-airona" }
      @current_email_hash = Digest::SHA256.hexdigest(current_user.email.strip.downcase) if current_user
    end

    def check_and_authenticate_user
      session[:return_to] = request.url
      redirect_to new_user_session_path unless user_signed_in?
    end
end
