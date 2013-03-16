require 'spec_helper'

# Categories aren't necessarily made by the User and thus 
# should have reasonably tight validations.

# TODO: Consider adding material_cost_per_unit
# Consider: how to handle non linear price per unit costs (added front load cost)
# Hydroseeding per load v per sq foot; rounding up to the load amount

describe WorkCategory do
  let(:work_category) { FactoryGirl.create(:work_category) }

  subject { work_category }

  it { should respond_to(:name) }
  it { should respond_to(:price_per_unit) }
  it { should respond_to(:unit) }
  it { should respond_to(:labor_time_per_unit) }
  it { should respond_to(:is_taxable) }

  it { should be_valid }

  describe "when name is longer than 50 characters" do
    before { work_category.name = "N" * 51 }
    it { should_not be_valid }
  end

  describe "when price_per_unit is nil" do
    before { work_category.price_per_unit = nil }
    it { should_not be_valid }
  end

  describe "when unit is nil" do
    before { work_category.unit = nil }
    it { should_not be_valid }
  end

  describe "when labor_time_per_unit is nil" do
    before { work_category.labor_time_per_unit = nil }
    it { should_not be_valid }
  end

  describe "when is_taxable is nil" do
    before { work_category.is_taxable = nil }
    it { should_not be_valid }
  end

  #valid
  describe "when is_taxable is false" do
    before { work_category.is_taxable = false }
    it { should be_valid }
  end
end
