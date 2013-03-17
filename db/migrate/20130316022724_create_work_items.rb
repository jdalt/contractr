class CreateWorkItems < ActiveRecord::Migration
  def change
    create_table :work_items do |t|
      t.references :work_category
      t.integer :work_amount
      t.decimal :client_cost

      t.timestamps
    end
  end
end
