class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :token_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :name, :business, :password, :password_confirmation, :remember_me

  before_save { |user| user.email = email.downcase }

	validates :email, format: { with: VALID_EMAIL_REGEX }, allow_blank: true
  validates :name, length: { maximum: 50 }, presence: true
  validates :business, length: { maximum: 50 }, presence: true
end
