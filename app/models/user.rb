class User < ApplicationRecord
  has_secure_password
  has_many :documents
  has_one :account
  accepts_nested_attributes_for :account, allow_destroy: true

  scope :by_status, -> status { where(status: status) }
  scope :by_date, -> fecha_de_emision { where(fecha_de_emision: fecha_de_emision) }
  scope :by_period, -> started_at, ended_at { where(fecha_de_emision: started_at..ended_at) }
  scope :by_days, -> days { where(fecha_de_emision: Date.today..days.to_i.days.from_now) }

  validates_presence_of :email, :password_digest
  validates_uniqueness_of :email

  def full_name
    "#{account.name.capitalize} #{account.last_name.capitalize}"
  end
end
