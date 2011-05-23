require 'client/dungeon_map'

class Player
  def initialize
    @dungeon_map = DungeonMap.new
  end

  def enter_dungeon(dungeon)
    @dungeon = dungeon
    @dungeon_map.reset
    @result = nil
    enter_room(@dungeon.entrance)
  end

  def enter_room(room)
    prev_room = current_room

    @current_room = if room.kind_of?(Integer)
                      @dungeon_map.lookup(room) || @dungeon.reveal_room(room)
                    else
                      room
                    end
    @dungeon_map.put(current_room, prev_room)
  end

  attr_reader :current_room

  def previous_room
    @dungeon_map.lookup_entrance_to(current_room.id)
  end

  def current_exits
    current_room.exits
  end

  def result
    @result ||= if current_room.type == :treasure_chamber
                  :won
                elsif @dungeon_map.unvisited_exits.empty?
                  :lost
                end
  end

  def visited?(room)
    !!@dungeon_map.lookup(room.id)
  end
end
