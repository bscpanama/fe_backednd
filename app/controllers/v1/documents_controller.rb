module V1
  class DocumentsController < ApplicationController
    has_scope :by_status
    has_scope :by_date
    has_scope :by_period
    has_scope :by_days

    before_action :set_document, only: :show

    def index
      @documents = document_query.paginate(page: params[:page], per_page: 8)
      json_response(@documents)
    end


    def create
      base64data = Base64Service.new(document_params[:documento_xml])
      @document = current_user.documents.create!(document_params.except(:documento_xml))
      @document.documento_xml.attach(
        io: base64data.file,
        filename: "#{SecureRandom.uuid}.xml"
      )
      base64data.close
      json_response(@document, :created)
    end

    def show
      json_response(@document)
    end

    private

    def document_params
      params.permit(:cufe, :documento_xml, :tipo_documento, :documento_relacionado, :razon_social, :ruc, :direccion_del_emisor, :cliente, :ruc_cedula_cliente, :direccion_cliente, :numero_factura, :serie, :fecha_de_emision, :suma, :descuento, :valor_pago, :forma_de_pago, :vuelto, :protocolo_de_autorizacion, :fecha_de_protocolo, items: [:codigo, :descripcion, :unid, :vlr_unit, :cantidad, :ITBMS, :vlr_item])
    end

    def set_document
      @document = Document.where(user: current_user).where(id: params[:id]).first
    end

    def document_query
      current_user.kind_of?(Admin) ? apply_scopes(Document).all : apply_scopes(Document).where(user: current_user)
    end
  end
end
