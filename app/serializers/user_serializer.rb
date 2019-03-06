class UserSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :email, :account
end
