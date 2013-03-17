class RemoveClientCostFromWorkItem < ActiveRecord::Migration
  def up
    remove_column :work_items, :client_cost
  end

  def down
    add_column :work_items, :client_cost, :decimal
  end
end
