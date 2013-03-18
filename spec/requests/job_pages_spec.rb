require 'spec_helper'

describe "Job pages" do
	subject { page }

  describe "new" do
    before do
      visit new_job_path
    end
    it { should have_selector('h1', text: 'Create New Job') }
    it { should have_selector('title', text: 'Job') }
  end

  describe "show" do
    let(:job) { FactoryGirl.create(:job) }

    #TODO: write a test to demonstrate prevention against XSS
    #on the title
    # create job with xss injection name and test for element visibility?
    before { visit job_path(job) }
    it { should have_selector('h1', text: job.name) }
    it { should have_selector('title', text: job.name) }
    it { should have_content(job.total_cost) }
  end

  describe "index" do
    #test me you fool
  end
end

