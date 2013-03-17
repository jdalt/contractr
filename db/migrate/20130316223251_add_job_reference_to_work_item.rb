class AddJobReferenceToWorkItem < ActiveRecord::Migration
  def change
    add_column :work_items, :job_id, :integer
  end
end
