class AddAccountStatusesToAccount < ActiveRecord::Migration[5.2]
  def up
    execute <<-SQL
        CREATE TYPE account_statuses AS ENUM ('activo', 'inactivo');
          ALTER TABLE "accounts" ALTER COLUMN "status" TYPE account_statuses USING status::account_statuses;
    SQL
  end

  def down
    execute <<-SQL
      DROP TYPE account_statuses;
    SQL
    change_column :accounts, :status, :string
  end
end
