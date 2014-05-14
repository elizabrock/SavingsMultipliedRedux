class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate!, unless: :devise_controller?
  before_action :load_auction_search

  protected

  def configure_permitted_parameters
    user_params = [:first_name, :last_name, :relationship_to_children_id, :child_configuration_id, :terms_accepted, :email_is_used_with_paypal, :bio, :profile_image]
    devise_parameter_sanitizer.for(:sign_up) << user_params
    devise_parameter_sanitizer.for(:account_update) << user_params
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  def authenticate!
    unless current_admin_user
      authenticate_user!
    end
  end

  def load_auction_search
    @auction_search = AuctionSearch.new(params[:auction_search])
  end
end
