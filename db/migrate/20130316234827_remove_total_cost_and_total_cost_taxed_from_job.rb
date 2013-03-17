class RemoveTotalCostAndTotalCostTaxedFromJob < ActiveRecord::Migration
  def up
    remove_column :jobs, :total_cost
    remove_column :jobs, :total_cost_taxed
  end

  def down
    add_column :jobs, :total_cost_taxed, :decimal
    add_column :jobs, :total_cost, :decimal
  end
end
