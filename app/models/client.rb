class Client < ActiveRecord::Base
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  attr_accessible :city, :email, :name, :phone, :state, :street, :zip

  before_validation do |client|
    client.phone = phone.gsub(/\D/, '')
  end


  validates :name, presence: true, length: { maximum: 50 }
  validates :state, presence: true
  validates :phone, length: { is: 10 }, allow_blank: true
end
