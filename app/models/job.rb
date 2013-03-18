class Job < ActiveRecord::Base
  attr_accessible :is_bid, :is_billed, :is_paid, :name, :work_items_attributes

  has_many :work_items, :inverse_of => :job, :dependent => :destroy
  accepts_nested_attributes_for :work_items, allow_destroy: true

  # default value
  before_validation { |job| job.is_bid ||= true }

  validates :name, presence: true, length: { maximum: 150 }

  def total_cost
    #TODO: do this calculation with SQL
    sum = 0
    work_items.each do |item|
      sum += item.client_cost
    end
    sum
  end
end
