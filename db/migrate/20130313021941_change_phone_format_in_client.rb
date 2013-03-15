class ChangePhoneFormatInClient < ActiveRecord::Migration
  def up
    change_column :clients, :phone, :string
  end

  def down
    change_column :clients, :phone, :integer
  end
end
