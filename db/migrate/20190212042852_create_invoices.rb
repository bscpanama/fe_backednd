class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.date :date
      t.string :number
      t.string :document_type
      t.string :status
      t.integer :user_id

      t.timestamps
    end
  end
end
