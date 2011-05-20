class Player
  attr_reader :current_room

  def enter(dungeon)
    entrance = dungeon.enter
    @current_room = entrance
  end
end
