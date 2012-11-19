class Shout < ActiveRecord::Base
	belongs_to :user

	validates_length_of :content, :in => 1..140
	validates_existence_of :user, :both => false
end
