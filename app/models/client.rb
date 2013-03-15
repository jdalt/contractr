class Client < ActiveRecord::Base
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  attr_accessible :city, :email, :name, :phone, :state, :street, :zip

  before_validation { |client| client.phone = phone.gsub(/\D/, '') }

  before_save { |client| client.email = email.downcase }


	validates :email, format: { with: VALID_EMAIL_REGEX }, allow_blank: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :phone, length: { is: 10 }, allow_blank: true
  validates :state, presence: true
  validates :zip, length: { is: 5 }, allow_nil: true
end
