class AddClaveDeAccesoToDocuments < ActiveRecord::Migration[5.2]
  def change
    add_column :documents, :clave_de_acceso, :string
  end
end
