class User < ActiveRecord::Base
  #TODO: DRY up
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  before_save { |user| user.email = email.downcase }

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :token_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :name, :business, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

	validates :email, format: { with: VALID_EMAIL_REGEX }, allow_blank: true
  validates :name, length: { maximum: 50 }, presence: true
  validates :business, length: { maximum: 50 }, presence: true
  # validates :email ?
end
