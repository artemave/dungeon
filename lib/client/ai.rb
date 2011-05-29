module AI
  class DepthFirstSearch
    attr_reader :player

    def initialize(player)
      @player = player
    end

    def suggest_next_room
      current_room = player.current_room
      visited_rooms = player.visited_rooms

      ( current_room.exits - visited_rooms ).sample || current_room.entrance.try(:id)
    end
  end
end
