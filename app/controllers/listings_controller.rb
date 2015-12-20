class ListingsController < ApplicationController

	def index
		# byebug
		@listings = Listing.all
	end

	def new
		@listing = Listing.new
	end

	def create
		# byebug
		@listing = Listing.new(listing_params)

		@listing.save!
		# byebug
		redirect_to @listing
	end

	def show
		@listing = Listing.find(params[:id])
		@booking = Booking.new
		@token = generate_client_token
	end

	def edit
		@listing = Listing.find(params[:id])
	end
	def update
		@listing = Listing.find(params[:id])
		if @listing.update(listing_params)
			redirect_to @listing
		else
			render :edit
		end
	end

	def destroy
		@listing = Listing.find(params[:id])
		@listing.destroy
		redirect_to listings_path
	end

	private
	def listing_params
		params.require(:listing).permit(:name, :description, :city, :address, :price_per_night, :room_type, :no_of_guest, {avatars:[]}, :tag_list).merge(user_id: current_user.id)
	end

	def generate_client_token
		Braintree::ClientToken.generate
	end
end