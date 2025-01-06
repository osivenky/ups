class RefreshUpsTokenJob < ApplicationJob
  queue_as :default

  def perform(user)
    token = user.ups_token
    return unless token.expired?

    response = Faraday.post('https://www.ups.com/oauth/v1/token') do |req|
      req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
      req.body = {
        client_id: 'your_ups_client_id',
        client_secret: 'your_ups_client_secret',
        refresh_token: token.refresh_token,
        grant_type: 'refresh_token'
      }
    end

    if response.status == 200
      token_data = JSON.parse(response.body)
      token.update(
        access_token: token_data['access_token'],
        expires_at: Time.current + token_data['expires_in'].to_i
      )
    else
      Rails.logger.error("Failed to refresh UPS token for user #{user.id}")
    end
  end
end
