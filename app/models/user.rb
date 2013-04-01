class User < ActiveRecord::Base
  attr_accessible :email, :name, :business, :password, :password_confirmation, :remember_me

  devise :database_authenticatable, :registerable, :token_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  #TODO:  This will be converted to relationship on a business
  #       model at a later date.
  has_many :jobs, :inverse_of => :user, :dependent => :destroy
  has_many :clients, :inverse_of => :user, :dependent => :destroy

  before_save { |user| user.email = email.downcase }

	validates :email, format: { with: VALID_EMAIL_REGEX }, allow_blank: true
  validates :name, length: { maximum: 50 }, presence: true
  validates :business, length: { maximum: 50 }, presence: true
end
