class AccountSerializer
  include FastJsonapi::ObjectSerializer
  belongs_to :user

  attributes :id, :name, :last_name, :company, :status

  attribute :avatar_url do |object|
    Rails.application.routes.url_helpers.rails_blob_url(object.avatar) if object.avatar.attached?
  end
end
