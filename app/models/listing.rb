class Listing < ActiveRecord::Base
	belongs_to :user
	has_many :bookings
	mount_uploaders :avatars, AvatarUploader
	geocoded_by :address   # can also be an IP address
	after_validation :geocode  
	
	searchkick match: :word_start, searchable: [:city, :address]
end

