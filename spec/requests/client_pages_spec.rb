require 'spec_helper'

describe "Client pages" do
  # TODO: consider replacing with a faster helper
  let!(:user) { FactoryGirl.create(:user) }
  before do
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
  end
	subject { page }

  describe "new" do
    before do
      visit new_user_client_path(user)
    end
    it { should have_selector('h1', text: 'Add New Client') }
    it { should have_selector('title', text: 'Add New Client') }

    let(:submit) { "Create New Client" }

    #invalid
    describe "with invalid information" do
      it "should not create a client" do
        expect { click_button submit }.not_to change(Client, :count)
      end
      it "should show an error message" do
        click_button submit
        should have_selector '#error_explanation'
      end
    end

    #valid
    describe "with valid information" do
      let(:client_name) { "Jon Doe" }
      before do
        fill_in "Name",     with: client_name
        fill_in "Street",   with: "123 Apple St"
        fill_in "City",     with: "Stillwater"
        fill_in "State",    with: "MN"
        fill_in "Email",    with: "user@example.com"
        fill_in "Phone",    with: "123-456-7890"
        fill_in "Zip",      with: "12345"
      end

      it "should create a client" do
        expect { click_button submit }.to change(Client, :count).by(1)
      end

      describe "should redirect to the client profile page" do
        before { click_button submit }
        it { should have_selector('title', text: client_name) }
      end
      describe "should have flash a success message" do
        before { click_button submit }
        it { should have_selector('.alert-success') }
      end
    end
  end


end
