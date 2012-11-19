class User < ActiveRecord::Base
	attr_accessible :email
	attr_accessible :password_digest
	attr_accessible :username
	attr_accessible :password
	attr_accessible :profile_image
	attr_accessible :profile_bg
	attr_accessible :profile_fg

	attr_accessor :password_digest
	attr_accessor :profile_image_file

	has_secure_password

	has_many :shouts, :dependent => :destroy

	validates_presence_of :email, :message => "is required, please add one!"
	validates_presence_of :username, :message => "is required, please add one!"
	validates_presence_of :password, :message => "is required, please add one!"
	validates_uniqueness_of :email
	validates_uniqueness_of :username
	validates_length_of :password, :in => 6..20, :message => "6 to 20 characters!", :on => 'create'
	validates_length_of :username, :in => 1..40, :message => "1 to 40 characters!"
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :message => "is not valid!"
	validates_format_of :username, :with => /^[a-zA-Z][a-zA-Z0-9_]*$/
	validates_exclusion_of :username, :in => "admin, kyle, leo"

	after_save :store_profile_image

	IMAGE_STORE = "#{Rails.root}/public/image_store"

	def profile_image_filename
		return "#{IMAGE_STORE}/#{id}.#{image_type}"
	end

	# at upload assign file_data to instance var and grab image type 
	def profile_image=(file_data)
		unless file_data.blank?
			# assign uploaded data to instance variable
			@file_data = file_data
			# assign image type (extension) to self.image_type
			self.image_type = file_data.original_filename.split('.').last.downcase
		end 
	end

	# define method to retrieve relative URI for the stored image # in the /public directory of the app, for use in HTML
	def profile_image_uri
		return "/image_store/#{id}.#{image_type}" 
	end

	# define method to determine if a review has an image on the # file system at the location specified by image_filename 
	def has_profile_image?
		return File.exists? profile_image_filename 
	end

	# after saving other date, store image on file system # mark store_image method private
	private

	def store_profile_image 
		if @file_data
			# create directory at IMAGE_STORE if it does not exist
			FileUtils.mkdir_p IMAGE_STORE
			# save image to file location and name from image_filename method 
			File.open(profile_image_filename, 'wb') do |f|
				f.write(@file_data.read) 
			end
			# nil file_data in memory so it won't be resaved
			@file_data = nil 
		end
	end

end