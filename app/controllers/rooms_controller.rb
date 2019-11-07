class RoomsController < ApplicationController
  before_action :set_rooms, only: [:listing, :pricing, :description, :photos, :amenities, :location]

  def new
    @room = current_user.rooms.new
  end

  def create
    @room = current_user.rooms.new(room_params)
    if @room.save
      redirect_to listing_room_url(@room)
    else
      flash[:alert] = "Something went wrong"
      render 'new'
    end
  end

  def listing
  end

  def pricing
  end
  
  def description
  end

  def photos
  end

  def amenities
  end

  def location
  end

  private
  def room_params
    params.require(:room).permit(:home_type,:room_type,:guest_count,:bedroom_count,:bathroom_count)
  end

  def set_rooms
    @room = Room.find(params[:id])
  end
end
