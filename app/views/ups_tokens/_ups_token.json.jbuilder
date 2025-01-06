json.extract! ups_token, :id, :access_token, :refresh_token, :expires_at, :user_id, :created_at, :updated_at
json.url ups_token_url(ups_token, format: :json)
