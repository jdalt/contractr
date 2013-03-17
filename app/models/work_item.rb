class WorkItem < ActiveRecord::Base
  attr_accessible :work_amount, :work_category

  belongs_to :work_category

  validates :work_amount, presence: true
  validates :work_category, presence: true
  validates :job_id, presence: true

  def client_cost
    work_category.price_per_unit * work_amount
  end
end
