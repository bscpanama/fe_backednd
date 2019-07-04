class ChangeAccountsPhoneNumberAndMobileNumber < ActiveRecord::Migration[5.2]
  def change
    change_column :accounts, :phone_number, :string
    change_column :accounts, :mobile_number, :string
  end
end
