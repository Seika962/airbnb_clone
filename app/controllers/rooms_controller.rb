class RoomsController < ApplicationController
  def new
    @room = current_user.rooms.new
  end
end
