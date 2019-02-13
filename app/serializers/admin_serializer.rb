class AdminSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :email, :password, :password_confirmation, :created_at, :updated_at
end
