require './spec/spec_helper'
require 'client/player'

describe Player do
  before do
    @player = Player.new
  end

  context 'in order to start the game' do
    it 'should enter the dungeon' do
      entrance = double('Room', :type => :whatever)
      dungeon = double('Dungeon', :entrance => entrance)

      @player.current_room.should_not be entrance
      @player.enter_dungeon(dungeon)
      @player.current_room.should be entrance
    end
  end

  context 'in order to win the game' do
    it 'should find the treasure chamber' do
      treasure_chamber = double('Room', :type => :treasure_chamber)
      dungeon = double('Dungeon', :reveal_room => treasure_chamber)
      @player.send(:dungeon=, dungeon)

      @player.result.should_not eq :won
      @player.enter_room(treasure_chamber)
      @player.result.should eq :won
    end
  end

  context 'in order to find the treasure chamber' do
    it 'should move to other rooms' do
      room = double('Room', :id => 42, :type => :whatever)

      dungeon = double('Dungeon', :reveal_room => room)
      dungeon.should_receive(:reveal_room).with(room.id)
      @player.send(:dungeon=, dungeon)

      @player.current_room.should_not be room
      @player.enter_room(room.id)
      @player.current_room.should be room
    end
  end

  context 'in order to move to other rooms' do
    it 'should follow exits from the current room' do
      room = double('Room', :exits => [1,3,42], :type => :whatever)
      @player.enter_room(room)

      @player.next_room_id.should be_in room.exits
    end
  end

  context 'in order to try different routes' do
    it 'should be able to go back to the previous room' do
      room1 = double('Room', :type => :whatever)
      room2 = double('Room', :type => :whatever)

      @player.enter_room(room1)
      @player.previous_room.should be nil

      @player.enter_room(room2)
      @player.previous_room.should be room1
    end
  end
  end

  context 'in order to not loop endlessly' do
    it 'should not follow visted exits'
  end

  context 'in order to complete a certain path' do
    it 'should not go back from a room before all exits are visited'
  end

  it 'should admit defeat if there are no possible moves'

end
