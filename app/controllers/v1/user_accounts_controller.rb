module V1
  class UserAccountsController < ApplicationController
    has_scope :by_status
    has_scope :by_date
    has_scope :by_period
    has_scope :by_days

    before_action :admin?
    before_action :set_user, only: [:show, :update, :destroy]
    before_action :set_host_for_local_storage

    def index
      @users = user_account_query.paginate(page: params[:page], per_page: 8)
      json_response(@users)
    end

    def create
      new_password = SecureRandom.hex(10)
      @user = User.create(user_params.merge({password: new_password, password_confirmation: new_password}))
      ExpireAccountJob.set(wait_until: @user.account.expiration_date.noon).perform_later(@user)
      UserMailer.new_account(@user, new_password).deliver_later
      json_response(@user, :created)
    end

    def show
      json_response(@user)
    end

    def destroy
      @user.destroy
      head :no_content
    end

    def update
      @user.update(user_params)
      head :no_content
    end

    private

    def user_params
      params.permit(
        :id,
        :email,
        :password,
        :password_confirmation,
        account_attributes: [
          :id,
          :name,
          :last_name,
          :phone_number,
          :mobile_number,
          :avatar,
          :status,
          :company,
          :plan_id
        ]
      )
    end

    def set_user
      @user = User.find_by(id: params[:id])
    end

    def set_host_for_local_storage
      ActiveStorage::Current.host = request.base_url if Rails.application.config.active_storage.service == :local
    end

    def user_account_query
      apply_scopes(User).all
    end
  end
end
