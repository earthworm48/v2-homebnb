class BookingMailer < ApplicationMailer

	def booking_email (customer,host,booking_id)
		@host = host
		@customer = customer
		# byebug
		mail(to: @host.email, subject: "You have received a booking from #{@customer.name}")
	end
end