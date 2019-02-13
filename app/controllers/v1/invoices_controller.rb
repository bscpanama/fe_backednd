module V1
  class InvoicesController < ApplicationController
    before_action :set_invoice, only: [:show, :update, :destroy]

    def index
      @invoices = Invoice.where(user: current_user)
      json_response(@invoices)
    end

    def create
      @invoice = current_user.invoices.create!(invoice_params)
      json_response(@invoice, :created)
    end

    def show
      json_response(@invoice)
    end

    def destroy
      @invoice.destroy
      head :no_content
    end

    def update
      @invoice = Invoice.update(invoice_params)
      head :no_content
    end

    private

    def invoice_params
      params.permit(:date, :document_type, :number, :status, :updated_at, :created_at)
    end

    def set_invoice
      @invoice = Invoice.where("user = ? && id = ?", current_user, params[:id]).first
    end
  end
end
