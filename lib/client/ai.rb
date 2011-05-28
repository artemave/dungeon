module AI
  class NoBrainer
    attr_reader :player

    def initialize(player)
      @player = player  
    end

    def suggest_next_room
      current_room = player.current_room
      visited_rooms = player.dungeon_map.visited_rooms

      ( current_room.exits - visited_rooms ).sample || player.dungeon_map.lookup_entrance_to(current_room.id)
    end
  end
end
