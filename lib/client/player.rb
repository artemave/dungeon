require 'client/dungeon_map'
require 'client/ai'

class Player
  attr_reader :current_room, :dungeon_map, :ai, :dungeon

  def initialize
    @dungeon_map = DungeonMap.new
    @ai = AI::NoBrainer.new(self)
  end

  def enter(dungeon)
    @dungeon = dungeon
    @current_room = dungeon.entrance
    dungeon_map.start(@current_room)
  end

  def next_room!
    prev_room = current_room
    @current_room = dungeon.get_room(ai.suggest_next_room)
    dungeon_map.put(@current_room, prev_room)
    @current_room
  end

  def result
    @result ||= if current_room.type == :treasure_chamber
                  :won
                elsif dungeon_map.unvisited_exits.empty?
                  :lost
                end
  end
end
