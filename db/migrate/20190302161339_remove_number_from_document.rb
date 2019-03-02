class RemoveNumberFromDocument < ActiveRecord::Migration[5.2]
  def change
    remove_column :documents, :number
    remove_column :documents, :document_type
    remove_column :documents, :date
  end
end
