class Account < ApplicationRecord
  PLAN = { 1 => 30, 2 => 90, 3 => 180, 4 => 365}
  attribute :avatar_url, :string
  enum status: {
    activo: "activo",
    inactivo: "inactivo"
  }

  has_one_attached :avatar
  belongs_to :user

  validates :avatar, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg', 'image/gif'], size_range: 1..2.megabytes }
  validates_presence_of :plan_id

  before_create :set_expiration

  def set_expiration
      self.expiration_date = PLAN[plan_id].days.from_now
  end

  def avatar_url
    Rails.application.routes.url_helpers.rails_blob_url(avatar, only_path: true) if avatar.attached?
  end

  def avatar_base64
    Base64Service.new(avatar.download)
  end

  def avatar_base64_data
    "data:image/jpeg;base64, #{avatar_base64}"
  end
end
