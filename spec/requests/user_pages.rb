require 'spec_helper'

describe "User pages" do
	subject { page }

  let(:user_password) { "foobarbazbagel" }
  let(:user_email) { "example_test@example.org" }
  let!(:user) { FactoryGirl.create(:user, email: user_email, password: user_password, password_confirmation: user_password) }

  describe "go to sign in page" do
    before do
      visit root_path
      click_link "Sign in"
    end

    #valid
    describe "fill in form with valid data" do
      before do
        fill_in "Email", with: user_email
        fill_in "Password", with: user_password
        click_button "Sign in"
      end

      # TODO: change this once home becomes populated with user specific data
      it { should have_selector('h1', text: "Home") }

      describe "go to profile" do
        before { click_link "Profile" }
        it { should have_selector('h1', text: user.name) }
      end
    end

    describe "fill in form with invalid data" do
      before do
        fill_in "Email", with: user_email
        fill_in "Password", with: user_password+"asdf"
        click_button "Sign in"
      end

      it { should have_content "Invalid" }
    end

    describe "go to sign up and provide valid data" do
      before do
        click_link "Sign up"
        fill_in "Name", with: "Jon Snow"
        fill_in "Email", with: "j.snow@northwall.org"
        fill_in "Business", with: "Acme Packing"
        fill_in "Password", with: "Foobarbaz"
        fill_in "Password confirmation", with: "Foobarbaz"
      end
      it "should create a user" do
        expect { click_button "Sign up" }.to change(User, :count).by(1)
      end
    end
  end


end
