class UserSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :email
  has_one :account
end
