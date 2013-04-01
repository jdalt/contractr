require 'spec_helper'

describe "menu" do
  subject { page }
  before { visit root_path }

  it { should have_link "Sign in", href: new_user_session_path }

  describe "with valid signed in user" do
    let!(:user) { FactoryGirl.create(:user) }
    before do
      visit new_user_session_path
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Sign in"
    end
    it { should have_link "New Job", href: new_user_job_path(user) }
    it { should have_link "All Jobs", href: user_jobs_path(user) }
    it { should have_link "Sign out", href: destroy_user_session_path }
  end
end
