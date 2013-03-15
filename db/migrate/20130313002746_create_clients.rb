class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.string :street
      t.string :city
      t.string :state
      t.integer :zip
      t.integer :phone
      t.string :email

      t.timestamps
    end

    add_index :clients, :name
  end
end
