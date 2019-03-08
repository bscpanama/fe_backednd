module V1
  class DocumentsController < ApplicationController
    before_action :set_document, only: :show

    def index
      @documents = document_query.paginate(page: params[:page], per_page: 8)
      json_response(@documents)
    end

    def create
      @document = current_user.documents.create!(document_params)
      json_response(@document, :created)
    end

    def show
      json_response(@document)
    end

    private

    def document_params
      params.permit(:cufe, :tipo_documento, :documento_relacionado, :razon_social, :ruc, :direccion_del_emisor, :cliente, :ruc_cedula_cliente, :direccion_cliente, :numero_factura, :serie, :fecha_de_emision, :suma, :descuento, :valor_pago, :forma_de_pago, :vuelto, :protocolo_de_autorizacion, :fecha_de_protocolo, items: [:codigo, :descripcion, :unid, :vlr_unit, :cantidad, :ITBMS, :vlr_item])
    end

    def set_document
      @document = Document.where(user: current_user).where(id: params[:id]).first
    end

    def document_query
      current_user.kind_of?(Admin) ? Document.all : Document.where(user: current_user)
    end
  end
end
