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

end

