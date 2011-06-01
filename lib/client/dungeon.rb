require 'client/room'

class Dungeon
  attr_reader :visited_rooms

  def initialize
    @visited_rooms = {}
  end

  def entrance
    @entrance ||= Room.find :one, from: '/entrance.xml'
    @visited_rooms[@entrance.id] = @entrance
  end

  def enter_room(id)
    @visited_rooms[id] ||= Room.find(id)
  end
end
