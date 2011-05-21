class Player
  attr_reader :current_room, :previous_room, :result

  def enter_dungeon(dungeon)
    enter_room(dungeon.entrance)
    self.dungeon = dungeon
  end

  def enter_room(room)
    @previous_room = @current_room

    @current_room = if room.kind_of?(Integer)
                      dungeon.reveal_room(room)
                    else
                      room
                    end
    set_result(@current_room)
  end

  def next_room_id
    @current_room.exits.sample
  end

  private

  attr_accessor :dungeon

  def set_result(room)
    @result = case room.type
              when :treasure_chamber
                :won
              end
  end
end
