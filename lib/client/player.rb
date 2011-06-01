require 'active_support/core_ext/module/delegation'
require 'client/ai'

class Player
  attr_reader :current_room, :ai, :dungeon

  def initialize
    @ai = AI::DepthFirstSearch.new(self)
  end

  def enter(dungeon)
    @dungeon = dungeon
    @current_room = dungeon.entrance
  end

  def next_room!
    if suggested_room_id = ai.suggest_next_room
      prev_room = current_room
      prev_visited_rooms = visited_rooms.keys

      room = dungeon.enter_room(suggested_room_id)

      if not room.id.in? prev_visited_rooms
        room.entrance = prev_room
      end
      @current_room = room
    end
  end

  delegate :visited_rooms, to: :dungeon

  def result
    @result ||= if current_room.type == :treasure_chamber
                  :won
                elsif ai.suggest_next_room.nil?
                  :lost
                end
  end
end
