class Listing < ActiveRecord::Base
	belongs_to :user
	has_many :bookings
	mount_uploaders :avatars, AvatarUploader
end
