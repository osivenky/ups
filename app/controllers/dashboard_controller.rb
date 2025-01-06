class DashboardController < ApplicationController
  # before_action :authenticate_user!
  before_action :validate_user!

  def index
    @api_key = current_user.api_keys.first.key
    @ups_connected = current_user.ups_token.present?
  end

  private 
  def validate_user!
    redirect_to new_user_registration_path unless current_user
  end
end
