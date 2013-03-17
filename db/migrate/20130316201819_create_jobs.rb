class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :name
      t.boolean :is_bid
      t.boolean :is_billed
      t.boolean :is_paid
      t.decimal :total_cost
      t.decimal :total_cost_taxed

      t.timestamps
    end

    add_index :jobs, :name 
  end
end
