class AccountSerializer
  include FastJsonapi::ObjectSerializer
  belongs_to :user

  attributes :id, :name, :last_name, :company, :status

end
