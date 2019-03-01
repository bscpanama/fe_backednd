class UsersController < ApplicationController
  skip_before_action :authorize_request, only: :create
  def create
    user = User.create!(user_params)
    auth_data = AuthenticateUser.new(user.email, user.password).call
    response = { message: Message.account_created, auth_data: auth_data }
    json_response(response, :created)
  end

  private

  def user_params
    params.permit(
      :email,
      :password,
      :password_confirmation,
      account_attributes: [
      :name,
      :last_name,
      :phone_number,
      :mobile_number
      ]
    )
  end
end
