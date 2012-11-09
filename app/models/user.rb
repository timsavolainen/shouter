class User < ActiveRecord::Base
	attr_accessible :email
	attr_accessible :password_digest
	attr_accessible :username
	attr_accessible :password

	attr_accessor :password_digest

	has_secure_password

	has_many :shouts

	validates_presence_of :email, :message => "is required, please add one!"
	validates_presence_of :username, :message => "is required, please add one!"
	validates_presence_of :password, :message => "is required, please add one!", :on => "create"
	validates_uniqueness_of :email
	validates_uniqueness_of :username

end
