class WorkItem < ActiveRecord::Base
  attr_accessible :work_amount, :work_category_id

  belongs_to :work_category
  belongs_to :job, :inverse_of => :work_items

  validates :work_amount, numericality: { only_integer: true },  presence: true
  # The following results in small perf penalty but better db integrity
  validates_presence_of :work_category
  validates_presence_of :job

  def client_cost
    work_category.price_per_unit * work_amount
  end
end
