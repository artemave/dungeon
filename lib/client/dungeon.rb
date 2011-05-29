require 'client/room'

class Dungeon
  def entrance
    @entrance ||= Room.find :one, from: '/entrance.xml'
  end

  def get_room(id)
    @rooms ||= {}
    @rooms[id] ||= Room.find(id)
  end
end
