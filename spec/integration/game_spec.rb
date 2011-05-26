require './spec/spec_helper'

describe 'adventure game' do
  it 'starts with player entering dungeon' do
    player = Player.new
    dungeon = Dungeon.new
    player.enter(dungeon)

    player.dungeon.should be dungeon
    player.current_room.should be dungeon.entrance
  end

  it 'consists of player visiting room according to chosen strategy' do
    player = Player.new
    dungeon = Dungeon.new
    player.enter(dungeon)

    player.strategy = GameStrategy::NoBrainer.new

    player.next_room.should be room1
    player.next_room.should be room2
    player.next_room.should be_in [room3, room4]
  end

  it 'is won when player found treasure chamber' do
  end

  it 'is lost if player has not found treasure chamber'
end
