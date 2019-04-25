class ChangeDocumentColumnsToString < ActiveRecord::Migration[5.2]
  def change
    change_column :documents, :numero_factura, :string
    change_column :documents, :ruc, :string
    change_column :documents, :numero_factura, :string
    change_column :documents, :serie, :string
    change_column :documents, :suma, :string
    change_column :documents, :descuento, :string
    change_column :documents, :valor_pago, :string
    change_column :documents, :vuelto, :string
    change_column :documents, :protocolo_de_autorizacion, :string
  end
end
