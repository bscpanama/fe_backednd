module V1
  class StatsController < ApplicationController
    before_action :valid_query, only: :index

    def index
      @stats = document_query.analytics(search_params[:query].to_sym, on: 'fecha_de_emision')
      json_response(@stats)
    end

    private

    def search_params
      params.permit(:query)
    end

    def valid_query
      ["weekly","monthly", "yearly"].include? search_params[:query]
    end

    def document_query
      current_user.kind_of?(Admin) ? Document.all : Document.where(user: current_user)
    end

  end
end
