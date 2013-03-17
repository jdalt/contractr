require 'spec_helper'

describe Job do
  let(:job) { FactoryGirl.create(:job) }
  let!(:cat) { FactoryGirl.create(:work_category) }

  subject { job }

  it { should respond_to(:name) }
  it { should respond_to(:total_cost) }
  it { should respond_to(:is_bid) }
  it { should respond_to(:is_billed) }
  it { should respond_to(:is_paid) }
  it { should respond_to(:work_items) }
  it { should respond_to(:fill_work_items) }

  it { should be_valid }

  describe "when name is nil" do
    before { job.name = nil }
    it { should_not be_valid }
  end

  describe "when name is longer than 150 characters" do
    before { job.name = "N" * 151 }
    it { should_not be_valid }
  end

  describe "when is_bid is nil" do
    before { job.is_bid = nil }
    it { should be_valid }
    specify { job.is_bid == true }
  end

  describe "fill_work_items should create records from params" do
    before do
      id = cat.id
      @params = [ 
        { work_category_id: id, work_amount: 12345 },
        { work_category_id: id, work_amount: 56789 }
      ]
      job.fill_work_items(@params)
      job.save!
    end
    specify { job.work_items[0].work_amount == @params[0][:work_amount] }
    specify { job.work_items[1].work_amount == @params[1][:work_amount] }
  end

  describe "total_cost should equal sum of work_item's client_cost" do
    before do
      amt1 = 12000
      amt2 = 22000
      job.work_items.build(work_category: cat, work_amount: amt1)
      job.work_items.build(work_category: cat, work_amount: amt2)
      job.save!
      @sum = amt1 * cat.price_per_unit + amt2 * cat.price_per_unit
    end
    specify { job.total_cost.should == @sum }
  end


end
