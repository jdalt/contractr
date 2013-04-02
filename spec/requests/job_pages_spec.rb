require 'spec_helper'

describe "Job pages" do
  # TODO: consider replacing with a faster helper
  let!(:user) { FactoryGirl.create(:user) }
  before { sign_in user }
	subject { page }

  describe "new" do
    let(:cat_name) { "hydro" }
    let(:ppu) { 0.1 }
    let(:amount) { 1000 }
    before do
      FactoryGirl.create(:work_category, name: cat_name, price_per_unit: ppu)
      visit new_user_job_path(user)
    end
    it { should have_selector('h1', text: 'Create New Job') }
    it { should have_selector('title', text: 'Job') }

    describe "when you fill in a work_item and a client name" do
      let(:submit) { "Save Job" }
      let(:job_name) { "Example Job" }
      before do
        fill_in "Job Name", with: job_name
        fill_in "Client Name", with: "John Snow"
        fill_in "State", with: "MN"
        find("#new_job table select").select cat_name
        find("#new_job table .work-item-amount").fill_in("", with: amount.to_s)
        # save_and_open_page
      end

      describe "with valid info it should create a job" do
        it "should create a job" do
          expect { click_button submit }.to change(Job, :count).by(1)
        end
        it "should create a client" do
          expect { click_button submit }.to change(Client, :count).by(1)
        end
      end

      describe "when you click submit with valid data it redirects to the job profile page" do
        before { click_button submit }
        it { should have_selector('title', text: job_name) }

        describe "the cost should be equal ppu*amount" do
          it { should have_selector('#job-total-cost', text: (ppu*amount).to_s) }
          it { should have_selector('.work-item-cost', text: (ppu*amount).to_s) }
        end
      end

      describe "with invalid info it should not create a job" do
        before do
          fill_in "State", with: ""
        end
        it "should not create a job" do
          expect { click_button submit }.not_to change(Job, :count).by(1)
        end
        it "should not create a client" do
          expect { click_button submit }.not_to change(Client, :count).by(1)
        end
      end
    end
  end

  describe "show" do
    let!(:job) { FactoryGirl.create(:job_with_items, user: user) }

    before { visit user_job_path(user, job) }
    it { should have_selector('h1', text: job.name) }
    it { should have_selector('title', text: job.name) }
    it { should have_content(job.work_items.first.work_category.name) }
    it { should have_content(job.total_cost) }

    describe "when job name has double title (xss threat)" do
      before do
        # this will create two titles unless the name is escaped by the db
        @xss_job = FactoryGirl.create(:job_with_items, name: "Hey</title><title>injection", user: user)
        visit user_job_path(user, @xss_job)
      end
      it { should_not have_selector('title', text: /\Ainjection\z/) }
    end
  end

  describe "index" do
    let(:job_name_un) { "Job 1" }
    let(:job_name_deux) { "Job 2" }
    let!(:job_un) { FactoryGirl.create(:job_with_items, name: job_name_un, user: user) }
    let!(:job_deux) { FactoryGirl.create(:job_with_items, name: job_name_deux, user: user) }
    before do
      visit user_jobs_path(user)
    end
    it { should have_selector('h3', text: job_name_un) }
    it { should have_selector('h3', text: job_name_deux) }
    describe "when a job is created it is marked as bid by defualt" do
      specify { find("#job_#{job_un.id} .bid").should have_selector('.icon-ok') }
    end
  end
end
