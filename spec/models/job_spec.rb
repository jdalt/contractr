require 'spec_helper'

describe Job do
  let(:job) { FactoryGirl.build(:job_with_items, work_item_count: 1) }
  let(:client) { FactoryGirl.build(:client) }
  let!(:cat) { FactoryGirl.create(:work_category) }

  subject { job }

  it { should respond_to(:name) }
  it { should respond_to(:client) }
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

  describe "when client is nil" do
    before { job.client_id = nil }
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
    let(:client_attrs) do
      { 
        "name" => "Example Name", 
        "city" => "Peoria",
        "state" => "IL",
        "email" => "",
        "phone" => "" 
      }
    end
    let(:work_item_attrs) do
      { 
        "0" => { "work_category_id" => cat.id.to_s, "work_amount" => 12345.to_s },
        "1" => { "work_category_id" => cat.id.to_s, "work_amount" => 56789.to_s }
      }

    end
    let(:params) do
      {
        "name" => "New Job", 
        "client_attributes" => client_attrs,
        "work_items_attributes" => work_item_attrs
      }
    end
    describe "that don't include any valid work_items" do
      before do
        params["work_items_attributes"]["0"]["work_category_id"] = ""
        params["work_items_attributes"]["1"]["work_category_id"] = ""
        @new_job = Job.new(params)
        @new_job.save
      end
      specify { @new_job.should_not be_valid }
    end

    describe "that include blank work_category_id" do
      before do
        # TODO: could also test for valid integer that is not a valid id
        params["work_items_attributes"]["0"]["work_category_id"] = ""
        @new_job = Job.new(params)
        @new_job.save!
      end
      specify { @new_job.work_items.all.count == 1 }
    end

    #valid
    describe "that do include valid parameters" do
      before do
        @new_job = Job.new(params)
        @new_job.save!
      end
      specify { @new_job.should be_valid }
      specify { @new_job.work_items[0].work_amount.should == 
                params["work_items_attributes"]["0"]["work_amount"].to_i }
      specify { @new_job.work_items[1].work_amount.should == 
                params["work_items_attributes"]["1"]["work_amount"].to_i }
    end
  end

  describe "total_cost should equal sum of work_item's client_cost" do
    before do
      job.work_items.destroy_all
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
