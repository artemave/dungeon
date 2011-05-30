require 'active_support/core_ext/module/delegation'
require 'client/dungeon_map'
require 'client/ai'

class Player
  attr_reader :current_room, :dungeon_map, :ai, :dungeon

  def initialize
    @dungeon_map = DungeonMap.new
    @ai = AI::DepthFirstSearch.new(self)
  end

  def enter(dungeon)
    @dungeon = dungeon
    @current_room = dungeon.entrance
    dungeon_map.put(@current_room)
  end

  def next_room!
    if suggested_room_id = ai.suggest_next_room
      prev_room = current_room
      room = dungeon.get_room(suggested_room_id)

      if not room.id.in? visited_rooms
        room.entrance = prev_room
        dungeon_map.put(room)
      end
      @current_room = room
    end
  end

  delegate :visited_rooms, to: :dungeon_map

  def result
    @result ||= if current_room.type == :treasure_chamber
                  :won
                elsif ai.suggest_next_room.nil?
                  :lost
                end
  end
end
