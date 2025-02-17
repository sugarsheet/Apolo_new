class BookingsController < ApplicationController

  def create
    @booking = Booking.new(booking_params)
    @office = Office.find(params[:office_id])
    @booking.office = @office
    @booking.user = current_user
    authorize @booking
    if @booking.save
      redirect_to dashboard_path, notice: "Your booking is confirmed!"

    else
     redirect_to office_path(@office)
    end
  end

  def new
    @booking = Booking.new
    authorize @booking
  end

  def decline
    @booking = Booking.find(params[:id])
    @booking.status = "declined"
    @booking.save
    redirect_to root_path
  end

  def accept
    @booking = Booking.find(params[:id])
    @booking.status = "accepted"
    @booking.save
    redirect_to root_path
  end

  def destroy
    @booking = @office.bookings.find(params[:id])
    @booking.destroy
    redirect_to office_booking_path
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :destroy)
  end
end
