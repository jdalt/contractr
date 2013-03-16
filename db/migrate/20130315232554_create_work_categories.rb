class CreateWorkCategories < ActiveRecord::Migration
  def change
    create_table :work_categories do |t|
      t.string :name
      t.decimal :price_per_unit
      t.string :unit
      t.decimal :labor_time_per_unit
      t.boolean :is_taxable

      t.timestamps
    end

    add_index :work_categories, :name
  end
end
