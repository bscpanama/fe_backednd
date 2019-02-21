class User < ApplicationRecord
  has_secure_password
  has_many :invoices
  has_one :account
  accepts_nested_attributes_for :account, allow_destroy: true

  validates_presence_of :email, :password_digest
  validates_uniqueness_of :email
end
