class AddExpirationDateToAccount < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :expiration_date, :date
  end
end
