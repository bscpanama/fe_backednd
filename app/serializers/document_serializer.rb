class DocumentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :cufe, :tipo_documento, :documento_relacionado, :razon_social, :ruc, :direccion_del_emisor, :cliente, :ruc_cedula_cliente, :direccion_cliente, :numero_factura, :serie, :fecha_de_emision, :suma, :descuento, :valor_pago, :forma_de_pago, :vuelto, :protocolo_de_autorizacion, :fecha_de_protocolo, :items, :status

  attribute :xml_url do |object|
    Rails.application.routes.url_helpers.rails_blob_url(object.documento_xml, only_path: true) if object.documento_xml.attached?
  end
end
