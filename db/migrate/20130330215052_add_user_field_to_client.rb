class AddUserFieldToClient < ActiveRecord::Migration
  def change
    add_column :clients, :user_id, :integer
  end
end
