require 'spec_helper'

describe WorkItem do
  let(:work_category) { FactoryGirl.create(:work_category) }
  let(:job) { FactoryGirl.create(:job) }
  let(:work_item) do
    job.work_items.create(work_category_id: work_category.id, work_amount: 4000)
  end

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
    specify { work_item.work_category.name.should == work_category.name }
  end

  describe "when work_amount is nil" do
    before { work_item.work_amount = nil }
    it { should_not be_valid }
  end

  describe "when client_cost should not be nil" do
    before { work_item.work_amount = nil }
    it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access to job_id" do
      expect do
        WorkItem.new(job_id: job.id, work_category_id: work_category.id, work_amount: 4000)
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
