class UpsController < ApplicationController
  before_action :authenticate_user!

  UPS_CLIENT_ID = 'your_ups_client_id'
  UPS_CLIENT_SECRET = 'your_ups_client_secret'
  REDIRECT_URI = 'http://localhost:3000/ups/callback'

  def connect
    authorization_url = "https://www.ups.com/oauth/v1/authorize?client_id=#{UPS_CLIENT_ID}&redirect_uri=#{REDIRECT_URI}&response_type=code"
    redirect_to authorization_url
  end

  def callback
    if params[:code].present?
      token_response = Faraday.post('https://www.ups.com/oauth/v1/token') do |req|
        req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
        req.body = {
          client_id: UPS_CLIENT_ID,
          client_secret: UPS_CLIENT_SECRET,
          code: params[:code],
          grant_type: 'authorization_code',
          redirect_uri: REDIRECT_URI
        }
      end

      if token_response.status == 200
        token_data = JSON.parse(token_response.body)
        current_user.create_ups_token(
          access_token: token_data['access_token'],
          refresh_token: token_data['refresh_token'],
          expires_at: Time.current + token_data['expires_in'].to_i
        )
        redirect_to root_path, notice: 'UPS connected successfully!'
      else
        redirect_to root_path, alert: 'UPS connection failed.'
      end
    else
      redirect_to root_path, alert: 'Authorization failed.'
    end
  end
end
