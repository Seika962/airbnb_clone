class RoomsController < ApplicationController
  before_action :set_rooms, only: [:listing, :pricing, :description, :photos, :amenities, :location]

  def new
    @room = current_user.rooms.new
  end

  def create
    @room = current_user.rooms.new(room_params)
    if @room.save
      redirect_to listing_room_url(@room)
      flash[:success] = "Successfully created!"
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
    @photos = @room.photos
  end

  def amenities
  end

  def location
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      flash[:success] = "Successfully updated!"
      redirect_back(fallback_location: root_url)
    else
      flash[:alert] = "Something went wrong"
      render 'listing'
    end
  end

  private
  def room_params
    params.require(:room).permit(:home_type,:room_type,:guest_count,:bedroom_count,:bathroom_count,:price,
    :listing_name,:description,:has_tv,:has_kitchen,:has_internet,:has_heater,:has_aircon,:address)
  end

  def set_rooms
    @room = Room.find(params[:id])
  end
end
