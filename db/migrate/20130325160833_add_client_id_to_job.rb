class AddClientIdToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :client_id, :integer
  end
end
