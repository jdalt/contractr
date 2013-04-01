class Job < ActiveRecord::Base
  attr_accessible :is_bid, :is_billed, :is_paid, :name, :work_items_attributes

  # TODO: inverse_of ?
  belongs_to :user
  belongs_to :client
  has_many :work_items, :inverse_of => :job, :dependent => :destroy
  accepts_nested_attributes_for :work_items, 
    reject_if: lambda { |a| a[:work_category_id].blank? },
    allow_destroy: true

  # default value
  before_validation { |job| job.is_bid ||= true }

  validates :name, presence: true, length: { maximum: 150 }
  validate :validate_has_work_items
  validates_presence_of :client
  validates_presence_of :user

  def validate_has_work_items
    errors.add(:work_items, "must have some work items") if work_items.length < 1
  end

  def total_cost
    sum = 0
    work_items.each do |item|
      sum += item.client_cost
    end
    sum
  end
end
