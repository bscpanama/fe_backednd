class RenameInvoicesToDocuments < ActiveRecord::Migration[5.2]
  def change
    rename_table :invoices, :documents
  end
end
