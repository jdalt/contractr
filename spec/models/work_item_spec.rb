require 'spec_helper'

describe WorkItem do
  let(:work_item) { FactoryGirl.build_stubbed(:work_item) }

  subject { work_item }

  it { should respond_to(:work_category) }
  it { should respond_to(:work_category_id) }
  it { should respond_to(:work_amount) }
  it { should respond_to(:client_cost) }
  it { should respond_to(:job_id) }
  it { should respond_to(:job) }

  it { should be_valid }

  describe "when work_category_id is nil" do
    before { work_item.work_category_id = nil }
    it { should_not be_valid }
  end

  describe "work_category should have a name" do
    specify { work_item.work_category.name.should_not be_blank }
  end

  describe "when work_amount is nil" do
    before { work_item.work_amount = nil }
    it { should_not be_valid }
  end

  describe "when work_amount is non-number" do
    before { work_item.work_amount = "asdf" }
    it { should_not be_valid }
  end

  describe "when client_cost should not be nil" do
    before { work_item.work_amount = nil }
    it { should_not be_valid }
  end

  describe "accessible attributes" do
  before do 
      @job = FactoryGirl.create(:job_with_items, work_item_count: 1)
      @cat = FactoryGirl.create(:work_category)
    end
    it "should not allow access to job_id" do
      expect do
        WorkItem.new(job_id: @job.id, work_category_id: @cat.id, work_amount: 4000)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when job_id is nil" do
    before { work_item.job_id = nil }
    it { should_not be_valid }
  end

  describe "client_cost should be correct" do
    before do
      work_item.work_amount = 2
      work_item.work_category.price_per_unit = 2
    end
    specify { work_item.client_cost.should == 4 }
  end
end
