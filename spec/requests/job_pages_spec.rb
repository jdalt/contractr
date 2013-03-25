require 'spec_helper'

describe "Job pages" do
	subject { page }

  describe "new" do
    let(:cat_name) { "hydro" }
    let(:ppu) { 0.1 }
    let(:amount) { 1000 }
    before do
      FactoryGirl.create(:work_category, name: cat_name, price_per_unit: ppu)
      visit new_job_path
    end
    it { should have_selector('h1', text: 'Create New Job') }
    it { should have_selector('title', text: 'Job') }

    describe "when you fill out a work_item" do
      let(:submit) { "Save Job" }
      let(:job_name) { "Example Job" }
      before do
        fill_in "Job Name", with: job_name
        find("#new_job table select").select cat_name
        find("#new_job table .work-item-amount").fill_in("", with: amount.to_s)
        # save_and_open_page
      end

      it "should create a job" do
        expect { click_button submit }.to change(Job, :count).by(1)
      end

      describe "when you click submit with valid data it redirects to the job profile page" do
        before { click_button submit }
        it { should have_selector('title', text: job_name) }

        describe "the cost should be equal ppu*amount" do
          it { should have_selector('#job-total-cost', text: (ppu*amount).to_s) }
          it { should have_selector('.work-item-cost', text: (ppu*amount).to_s) }
        end

      end
    end
  end

  describe "show" do
    let(:job) { FactoryGirl.create(:job_with_items) }

    before { visit job_path(job) }
    it { should have_selector('h1', text: job.name) }
    it { should have_selector('title', text: job.name) }
    it { should have_content(job.work_items.first.work_category.name) }
    it { should have_content(job.total_cost) }

    describe "when job name has double title (xss threat)" do
      before do
        # this will create two titles unless the name is escaped by the db
        @xss_job = FactoryGirl.create(:job, name: "Hey</title><title>injection")
        visit job_path(@xss_job)
      end
      it { should_not have_selector('title', text: /\Ainjection\z/) }
    end
  end

  describe "index" do
    let(:job_name_un) { "Job 1" }
    let(:job_name_deux) { "Job 2" }
    let!(:job_un) { FactoryGirl.create(:job_with_items, name: job_name_un) }
    let!(:job_deux) { FactoryGirl.create(:job_with_items, name: job_name_deux) }
    before do
      visit jobs_path
    end
    it { should have_selector('h3', text: job_name_un) }
    it { should have_selector('h3', text: job_name_deux) }
    describe "when a job is created it is marked as bid by defualt" do
      specify { find("#job_#{job_un.id} .bid").should have_selector('.icon-ok') }
    end
  end
end

