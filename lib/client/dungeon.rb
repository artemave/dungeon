require 'client/room'

class Dungeon
  def entrance
    Room.find :one, from: '/entrance.xml'
  end

  def get_room(id)
    Room.find(id)
  end
end
