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
      @user = User.create!(user_params)
      json_response(@user, :created)
    end

    def show
      json_response(@user)
    end

    def destroy
      @user.account.avatar.purge
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
