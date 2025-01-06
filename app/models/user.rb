class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_one :ups_token, dependent: :destroy
  has_many :api_keys, dependent: :destroy

  after_create :generate_api_key

  private

  def generate_api_key
    api_keys.create(key: SecureRandom.hex(20))
  end
end
