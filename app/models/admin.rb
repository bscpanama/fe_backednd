class Admin < ApplicationRecord
  has_secure_password

  validates_presence_of :email, :password_digest
  validates_uniqueness_of :email

  def full_name
    "Test Tester"
  end
end
