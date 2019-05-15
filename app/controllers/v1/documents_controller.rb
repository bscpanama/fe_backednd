module V1
  class DocumentsController < ApplicationController
    has_scope :by_status
    has_scope :by_date
    has_scope :by_period, using: %i[started_at ended_at], type: :hash
    has_scope :by_days

    before_action :set_document, only: :show

    def index
      @documents = document_query.paginate(page: params[:page], per_page: 8)
      options = {}
      options[:meta] = [pages: @documents.count/8.ceil]
      render json: DocumentSerializer.new(@documents, options).serialized_json
    end


    def create
      document_data = Base64Service.new(document_params[:documento_xml])
      qrcode_data = Base64Service.new(document_params[:qr_code])
      base64_qr = document_params[:qr_code]
      @document = current_user.documents.create!(document_params.except(:documento_xml, :qr_code))
      @document.documento_xml.attach(
        io: document_data.file,
        filename: "#{document_params[:cliente]}-#{document_params[:fecha_de_emision]}.xml"
      )
      document_data.close
      @document.qr_code.attach(
        io: qrcode_data.file,
        filename: "#{SecureRandom.uuid}.png"
      )
      @document.qr_code_base64 = base64_qr
      @document.save
      qrcode_data.close
      json_response(@document, :created)
    end

    def show
      json_response(@document)
    end

    private

    def document_params
      params.permit(:clave_de_acceso,:cufe, :qr_code, :documento_xml, :tipo_documento, :documento_relacionado, :razon_social, :ruc, :direccion_del_emisor, :cliente, :ruc_cedula_cliente, :direccion_cliente, :numero_factura, :serie, :fecha_de_emision, :suma, :descuento, :valor_pago, :forma_de_pago, :vuelto, :protocolo_de_autorizacion, :fecha_de_protocolo, items: [:codigo, :descripcion, :unid, :vlr_unit, :cantidad, :ITBMS, :vlr_item])
    end

    def set_document
      @document = Document.where(user: current_user).where(id: params[:id]).first
    end

    def document_query
      current_user.kind_of?(Admin) ? apply_scopes(Document).all : apply_scopes(Document).where(user: current_user)
    end
  end
end
