class Player
  attr_reader :current_room, :result

  def enter_dungeon(dungeon)
    entrance = dungeon.enter
    self.current_room = entrance
    self.dungeon = dungeon
  end

  def enter_room(room_id)
    self.current_room = dungeon.enter_room(room_id)
  end

  private

  attr_accessor :dungeon

  def set_result(room)
    @result = case room.type
              when :treasure_chamber
                :won
              end
  end

  def current_room=(room)
    @current_room = room
    set_result(room)
  end

end
