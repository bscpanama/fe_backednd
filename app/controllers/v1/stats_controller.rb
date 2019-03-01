module V1
  class StatsController < ApplicationController
    before_action :valid_query, only: :index

    def index
      @stats = Document.where(user: current_user).analytics(search_params[:query].to_sym)
      json_response(@stats)
    end

    private

    def search_params
      params.permit(:query)
    end

    def valid_query
      ["weekly","monthly", "yearly"].include? search_params[:query]
    end

  end
end
