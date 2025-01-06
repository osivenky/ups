class Api::V1::BaseController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_api_key!

  private

  def authenticate_api_key!
    api_key = request.headers['Authorization']
    unless ApiKey.exists?(key: api_key)
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
