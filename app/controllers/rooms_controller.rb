class RoomsController < ApplicationController
  def new
    @room = current_user.rooms.new
  end

  def create
    @room = current_user.rooms.new(room_params)
    if @room.save
      redirect_to listing_room_url(current_user)
    else
      flash[:alert] = "Something went wrong"
      render 'new'
    end
  end

  def listing
  end

  private
  def room_params
    params.require(:room).permit(:home_type,:room_type,:guest_count,:bedroom_count,:bathroom_count)
  end

end
