class Client < ActiveRecord::Base
  attr_accessible :city, :email, :name, :phone, :state, :street, :zip

  belongs_to :user

  before_validation { |client| client.phone = phone.gsub(/\D/, '') }

  before_save { |client| client.email = email.downcase }

	validates :email, format: { with: VALID_EMAIL_REGEX }, allow_blank: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :phone, length: { is: 10, message: "numbers should have 10 digits"  }, allow_blank: true
  validates :state, presence: true
  validates :zip, numericality: { only_integer: true }, length: { is: 5, message: "codes should have 5 digits" }, allow_nil: true
  validates_presence_of :user
end
