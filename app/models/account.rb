class Account < ApplicationRecord
  PLAN = { 1 => 30, 2 => 90, 3 => 180, 4 => 365}
  attribute :avatar_url, :string

  has_one_attached :avatar
  belongs_to :user

  validates :avatar, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..2.megabytes }
  validates_presence_of :plan_id

  after_create :set_expiration

  def set_expiration
    self.expiration_date = PLAN[plan_id].days.from_now
  end

  def avatar_url
    Rails.application.routes.url_helpers.rails_blob_url(avatar, only_path: true) if avatar.attached?
  end
end
