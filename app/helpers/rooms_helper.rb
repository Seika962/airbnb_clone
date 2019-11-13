module RoomsHelper
  def is_done?(form)
    unless form.blank?
      content_tag :i, "", class:"fa fa-check float-right pb-2 text-dark"
    end
  end

  def is_ready?(room)
    !room.price.blank? && !room.listing_name.blank? && !room.description.blank? && !room.photos.blank? && !room.address.blank?
  end
end
