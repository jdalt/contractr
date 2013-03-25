require 'spec_helper'

describe Client do
  let(:client) { FactoryGirl.build_stubbed(:client) }

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
  #valid
  describe "when phone is an empty string" do
    before { client.phone = "" }
    it { should be_valid }
  end

  describe "when phone includes numbers and digits with 10 digits" do
    before { client.phone = "123-456-7890" }
    it { should be_valid }
  end

  #invalid
  describe "when phone is 4 digits" do
    before { client.phone = "2345" }
    it { should_not be_valid }
  end

  describe "when phone is 12 digits" do
    before { client.phone = "5"*12 }
    it { should_not be_valid }
  end


  # *** Email Spec ***
  #valid
  describe "when email is an empty string" do
    before { client.email = "" }
    it { should be_valid }
  end

	describe "when email format is valid" do
		it "should be valid" do
			addresses = %w[user@foo.com A_USER_ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
			addresses.each do |valid_address|
				client.email = valid_address
				client.should be_valid
			end
		end
	end

  #invalid
	describe "when email format is invalid" do
		it "should be invalid" do
			addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
			addresses.each do |invalid_address|
				client.email = invalid_address
				client.should_not be_valid
			end
		end
	end

  # automatic conversion to lowercase
  describe "after saving model email is in lower case" do
    test_email = "ExAmPlE_UsEr@eXaMpLe.CoM"
    before do
      client.email = test_email
      client.save!
    end
    it { should be_valid }
    specify { client.email.should == test_email.downcase }
    specify { client.email.should_not == test_email }
  end

  # *** Zip Code Spec ***
  #valid
  describe "when zip is nil" do
    before { client.zip = nil }
    it { should be_valid }
  end

  describe "when zip is 5 digits" do
    before { client.zip = 12345 }
    it { should be_valid }
  end

  #invalid
  describe "when zip is non-numbers" do
    before { client.zip = "a12345" }
    it { should_not be_valid }
    before { client.zip = "a1234" }
    it { should_not be_valid }
    before { client.zip = "1234s" }
    it { should_not be_valid }
    before { client.zip = "12345s" }
    it { should_not be_valid }
  end

  describe "when zip is short (3 digits)" do
    before { client.zip = 123 }
    it { should_not be_valid }
  end

  describe "when zip is too long (7 digits)" do
    before { client.zip = 1234567 }
    it { should_not be_valid }
  end

end
