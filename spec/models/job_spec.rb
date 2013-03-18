require 'spec_helper'

describe Job do
  # TODO: Consider stubbing these objects
  let(:job) { FactoryGirl.build_stubbed(:job) }
  let!(:cat) { FactoryGirl.create(:work_category) }

  subject { job }

  it { should respond_to(:name) }
  it { should respond_to(:total_cost) }
  it { should respond_to(:is_bid) }
  it { should respond_to(:is_billed) }
  it { should respond_to(:is_paid) }
  it { should respond_to(:work_items) }

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

  describe "when built from params" do
    before do
      id = cat.id
      @params = { 
        "name" => "New Job", "work_items_attributes" => { 
          "0" => { "work_category_id" => id.to_s, "work_amount" => 12345.to_s },
          "1" => { "work_category_id" => id.to_s, "work_amount" => 56789.to_s }
        }
      }
      @new_job = Job.new(@params)
      @new_job.save!
    end
    specify { @new_job.should be_valid }
    specify { @new_job.work_items[0].work_amount.should == @params["work_items_attributes"]["0"]["work_amount"].to_i }
    specify { @new_job.work_items[1].work_amount.should == @params["work_items_attributes"]["1"]["work_amount"].to_i }
  end

  describe "total_cost should equal sum of work_item's client_cost" do
    before do
      amt1 = 12000
      amt2 = 22000
      job.work_items.build(work_category_id: cat.id, work_amount: amt1)
      job.work_items.build(work_category_id: cat.id, work_amount: amt2)
      job.save!
      @sum = amt1 * cat.price_per_unit + amt2 * cat.price_per_unit
    end
    specify { job.total_cost.should == @sum }
  end


end
