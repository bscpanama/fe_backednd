class AddColumnsToDocuments < ActiveRecord::Migration[5.2]
  def change
    add_column :documents, :cufe, :string
    add_column :documents, :tipo_documento, :string
    add_column :documents, :documento_relacionado, :string
    add_column :documents, :razon_social, :string
    add_column :documents, :ruc, :integer
    add_column :documents, :direccion_del_emisor, :string
    add_column :documents, :cliente, :string
    add_column :documents, :ruc_cedula_cliente, :string
    add_column :documents, :direccion_cliente, :string
    add_column :documents, :numero_factura, :integer
    add_column :documents, :serie, :integer
    add_column :documents, :fecha_de_emision, :date
    add_column :documents, :suma, :float
    add_column :documents, :descuento, :float
    add_column :documents, :valor_pago, :float
    add_column :documents, :forma_de_pago, :string
    add_column :documents, :vuelto, :float
    add_column :documents, :protocolo_de_autorizacion, :bigint
    add_column :documents, :fecha_de_protocolo, :datetime
    add_column :documents, :items, :json
  end
end
