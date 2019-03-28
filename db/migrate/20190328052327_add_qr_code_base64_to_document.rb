class AddQrCodeBase64ToDocument < ActiveRecord::Migration[5.2]
  def change
    add_column :documents, :qr_code_base64, :text
  end
end
