class WorkCategory < ActiveRecord::Base
  attr_accessible :is_taxable, :labor_time_per_unit, :name, :price_per_unit, :unit

  validates :name, presence: true, length: { maximum: 50 }
  validates :labor_time_per_unit, presence: true
  validates :price_per_unit, presence: true
  validates :unit, presence: true
  validates :is_taxable, inclusion: { in: [true, false], message: 'requires a true or false value' }
end
