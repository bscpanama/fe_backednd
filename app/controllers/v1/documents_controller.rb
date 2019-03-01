module V1
  class DocumentsController < ApplicationController
    before_action :set_document, only: [:show, :update, :destroy]

    def index
      @documents = Document.where(user: current_user).paginate(page: params[:page], per_page: 8)
      json_response(@documents)
    end

    def create
      @document = current_user.documents.create!(document_params)
      json_response(@document, :created)
    end

    def show
      json_response(@document)
    end

    def destroy
      @document.destroy
      head :no_content
    end

    def update
      @document = Document.update(document_params)
      head :no_content
    end

    private

    def document_params
      params.permit(:date, :document_type, :number, :status, :cufe)
    end

    def set_document
      @document = Document.where("user = ? && id = ?", current_user, params[:id]).first
    end
  end
end
