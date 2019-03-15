class AddStatusAndCompanyToAccount < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :company, :string
    add_column :accounts, :status, :string
  end
end
