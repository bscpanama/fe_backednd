require 'open-uri'
module V1
  class PdfsController < ApplicationController
    def show
      @document = Document.find(params[:id])
      result = PdfService.new(ActionController::Base.new.render_to_string('documents/show.html.erb', layout: false), "test.pdf").convert_from_html
      data = open(result.body['pdf'])
      send_data data.read, type: "application/pdf"
    end
  end
end
