class BookingsController < ApplicationController
	def create
		# byebug
		@booking = Booking.new(booking_params)
		# byebug
		@listing = @booking.listing
		nonce = params[:payment_method_nonce]

		if @booking.save!
			# render template: "bookings/payment"
			result = Braintree::Transaction.sale(
			  :amount => "100.00",
			  :payment_method_nonce => nonce
			)	
		end
		
		if result.success?
		  flash[:success] = "success!: #{result.transaction.id}"
		elsif result.transaction
		  flash[:danger] = "Error processing transaction:
		  code: #{result.transaction.processor_response_code}
		  text: #{result.transaction.processor_response_text}"
		  @booking.destroy
		else
		  flash[:danger] = result.errors
		  @booking.destroy
		end	

		redirect_to @listing
	end

	private
	def booking_params
		params.require(:booking).permit(:start_date, :end_date, :no_of_guest, :listing_id, :amount).merge(user_id: current_user.id)
	end
end