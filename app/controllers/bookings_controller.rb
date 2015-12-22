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
		  # byebug
		  BookingMailer.booking_email(@booking.user, @listing.user, @booking.id).deliver_now
		elsif result.transaction
		  flash[:danger] = "Error processing transaction:
		  code: #{result.transaction.processor_response_code}
		  text: #{result.transaction.processor_response_text}"
		  @booking.destroy
		else
		  flash[:danger] = result.errors
		  @booking.destroy
		end	

		redirect_to @booking.user
	end

	def edit
		# byebug
		@booking = Booking.find(params[:id])
	end

	def destroy
		@booking = Booking.find(params[:id])
		@booking.destroy
		flash[:success] = "Booking no.#{@booking.id}: Booking to #{@booking.listing.name} from #{@booking.start_date} to #{@booking.end_date} has successfully been destroyed!"

		redirect_to current_user
	end

	private
	def booking_params
		params.require(:booking).permit(:start_date, :end_date, :no_of_guest, :listing_id, :amount).merge(user_id: current_user.id)
	end
end