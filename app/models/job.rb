class Job < ActiveRecord::Base
  attr_accessible :is_bid, :is_billed, :is_paid, :name

  has_many :work_items, :dependent => :destroy

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

  def fill_work_items(attributes)
    attributes.each do |item|
      work_items.build( work_category_id: item[:work_category_id], work_amount: item[:work_amount])
    end
  end

        
end
