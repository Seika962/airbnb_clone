class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  include UsersHelper
  include RoomsHelper

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys: [:fullname])
    # for sign_up
    devise_parameter_sanitizer.permit(:account_update, keys: [:fullname, :phone_number, :description])
    # for edit 
  end
end
