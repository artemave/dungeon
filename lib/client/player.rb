class Player
  attr_reader :current_room, :result

  def enter(dungeon)
    entrance = dungeon.enter
    @current_room = entrance
  end

  def current_room=(room)
    @current_room = room
    set_result(room)
  end

  private

  def set_result(room)
    @result = case room.type
              when :treasure_chamber
                :won
              end
  end

end
