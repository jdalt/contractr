require 'spec_helper'

describe Client do
  let(:client) { FactoryGirl.create(:client) }

  subject { client }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:street) }
  it { should respond_to(:city) }
  it { should respond_to(:state) }
  it { should respond_to(:zip) }
  it { should respond_to(:phone) }

  it { should be_valid }

  describe "when name is longer than 50 characters" do
    before { client.name = "N" * 51 }
    it { should_not be_valid }
  end

  describe "when state is missing" do
    before { client.state = "" }
    it { should_not be_valid }
  end


  # *** Phone Number Spec ***
  describe "when phone is an empty string" do
    before { client.phone = "" }
    it { should be_valid }
  end

  describe "when phone is 4 digits" do
    before { client.phone = "2345" }
    it { should_not be_valid }
  end

  describe "when phone is 12 digits" do
    before { client.phone = "5"*12 }
    it { should_not be_valid }
  end

  describe "when phone includes numbers and digits" do
    before { client.phone = "123-456-7890" }
    it { should be_valid }
  end

	# describe "when email format is invalid" do
	# 	it "should be invalid" do
	# 		addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
	# 		addresses.each do |invalid_address|
	# 			client.email = invalid_address
	# 			client.should_not be_valid
	# 		end
	# 	end
	# end
end
