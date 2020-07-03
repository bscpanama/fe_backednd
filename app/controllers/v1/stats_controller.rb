module V1
  class StatsController < ApplicationController
    before_action :valid_query, only: :index

    def index
      @stats = if search_params[:query] == "monthly"
                 get_results(decument_query)
               else
                 document_query.analytics(search_params[:query].to_sym, on: 'fecha_de_emision')
               end
      json_response(@stats)
    end

    private

    def search_params
      params.permit(:query)
    end

    def valid_query
      %w[weekly monthly yearly].include? search_params[:query]
    end

    def document_query
      current_user.is_a?(Admin) ? Document.all : Document.where(user: current_user)
    end

    def get_results(query)
      dates = query.map(&:fecha_de_emision).compact
      processed = []
      results = {}

      dates.each do |date|
        month = Date::MONTHNAMES[date.month]
        year = date.year
        count = 0
        next if processed.include?("#{month},#{year}")

        processed << "#{month},#{year}"
        dates.each do |date_c|
          count += 1 if month == Date::MONTHNAMES[date_c.month] && year == date_c.year
        end
        results["#{month} #{year}".to_sym] = count
      end
      results
    end
  end
end
