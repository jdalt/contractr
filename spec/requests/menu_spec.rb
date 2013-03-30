require 'spec_helper'

describe "menu" do
  subject { page }
  before { visit root_path }

  it { should have_link "New Job", href: new_job_path }
  it { should have_link "All Jobs", href: jobs_path }
  it { should have_link "Sign in", href: new_user_session_path }
end
