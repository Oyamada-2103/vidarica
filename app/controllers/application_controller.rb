class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  add_flash_types :success, :info, :warning, :danger

  protected

  def after_sign_in_path_for(resource)
    if user_signed_in?
      post_images_path
    elsif admin_signed_in?
      admin_tags_path
    else
      root_path
    end
  end


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:account_name,:user_name,:gender,:birth_year])
  end
end
