class WorkItem < ActiveRecord::Base
  attr_accessible :work_amount, :work_category_id

  belongs_to :work_category
  belongs_to :job, :inverse_of => :work_items

  validates :work_amount, numericality: { only_integer: true },  presence: true
  validates :work_category_id, presence: true
  validates_presence_of :job

  def client_cost
    work_category.price_per_unit * work_amount
  end
end
