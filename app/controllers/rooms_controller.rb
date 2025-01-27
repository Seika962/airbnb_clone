class RoomsController < ApplicationController
  before_action :set_rooms, only: [:listing, :pricing, :description, :photos, :amenities, :location, :show, :preload, :preview]

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

  def index
    @rooms = current_user.rooms
  end

  def show
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

    final_params = (is_ready?(@room) ? room_params.merge(is_active: true) : room_params)

    if @room.update(final_params)
      flash[:success] = "Successfully updated!"
      redirect_back(fallback_location: root_url)
    else
      flash[:alert] = "Something went wrong"
      render 'listing'
    end
  end

  def preload
    today = Date.today
    reservations = @room.reservations.where("start_date >= ? OR end_date >= ?", today, today)

    render json: reservations
  end

  def preview
    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])

    output = {
      conflict: has_conflict(start_date, end_date, @room)
    }

    render json: output
  end

  private
  def room_params
    params.require(:room).permit(:home_type,:room_type,:guest_count,:bedroom_count,:bathroom_count,:price,
    :listing_name,:description,:has_tv,:has_kitchen,:has_internet,:has_heater,:has_aircon,:address)
  end

  def set_rooms
    @room = Room.find(params[:id])
  end

  def has_conflict(start_date, end_date, room)
    check = room.reservations.where("? < start_date AND end_date < ?", start_date, end_date)
    check.size > 0 ? true : false
  end
end
