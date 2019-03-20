class SetDefaults < ActiveRecord::Migration[5.2]
  def self.up
    change_column_default :accounts, :status, "activo"
    change_column_default :documents, :status, "activo"
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration, "Can't remove the default"
  end
end
