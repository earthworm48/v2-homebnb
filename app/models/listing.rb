class Listing < ActiveRecord::Base
	belongs_to :user
	has_many :bookings
	mount_uploaders :avatars, AvatarUploader

	searchkick match: :word_start, searchable: [:city, :address]
end

