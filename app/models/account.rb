class Account < ApplicationRecord
  has_one_attached :avatar
  belongs_to :user

  validates :avatar, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..2.megabytes }
end
