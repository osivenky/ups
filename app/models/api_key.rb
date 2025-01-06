class ApiKey < ApplicationRecord
  belongs_to :user
  validates :key, presence: true, uniqueness: true
end
