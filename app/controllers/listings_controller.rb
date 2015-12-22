class ListingsController < ApplicationController

	def index
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

	def search
		respond_to do |format|

			# when the 'search' button is clicked
			format.html do
				@listings = Listing.search(params[:term], fields: ["city", "address"], mispellings: {below: 5})
				# byebug/
				if @listings.blank?
					# byebug
					@error = "No result is found"
				end
				render :template => "listings/index"
			end

			# when user key in things
			format.json do
				@cities = Listing.search(params[:term], fields: ["city"], mispellings: {below: 5})
				@cities = @cities.map(&:city)
				@address = Listing.search(params[:term], fields: ["address"], mispellings: {below: 5})
				@address = @address.map(&:address)
				render json: (@cities + @address).uniq
			end
		end
	end


	private
	def listing_params
		params.require(:listing).permit(:name, :description, :city, :address, :price_per_night, :room_type, :no_of_guest, {avatars:[]}, :tag_list).merge(user_id: current_user.id)
	end

	def generate_client_token
		Braintree::ClientToken.generate
	end
end