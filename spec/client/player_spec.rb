require './spec/spec_helper'
require 'client/player'

describe Player do
  before do
    @dungeon = double('Dungeon')
    @dungeon_map = double('DungeonMap', :put => nil, :reset => nil, :lookup => nil)
    @room = double('Room', :id => 1, :exits => [2], :type => :room)
    @player = Player.new
    @player.instance_variable_set(:@dungeon, @dungeon)
    @player.instance_variable_set(:@dungeon_map, @dungeon_map)
    @player.instance_variable_set(:@current_room, @room)
  end

  context 'in order to start the game' do
    it 'should enter the dungeon' do
      entrance = double('Room', :id => 1)
      @dungeon.stub(:entrance).and_return(entrance)

      @player.current_room.should_not be entrance
      @player.enter_dungeon(@dungeon)
      @player.current_room.should be entrance
    end
  end

  context 'in order to win the game' do
    it 'should find treasure chamber' do
      treasure_chamber = double('Room', :type => :treasure_chamber)
      @dungeon_map.stub(:unvisited_exits).and_return([1])

      @player.result.should_not eq :won
      @player.instance_variable_set(:@current_room, treasure_chamber)
      @player.result.should eq :won
    end

  end

  context 'in order to find the treasure chamber' do
    it 'should move to other rooms' do
      next_room = double('Room', :id => 2)
      @dungeon.stub(:reveal_room).with(next_room.id).and_return(next_room)

      @player.current_room.should_not be next_room
      @player.enter_room(next_room.id)
      @player.current_room.should be next_room
    end
  end

  context 'in order to move to other rooms' do
    it 'should know exits from the current room' do
      @player.current_exits.should == [2]
    end

    context 'but not visit same rooms twice' do
      it 'should remember visited rooms' do
        room = double('Room', :id => 2)

        @dungeon_map.should_receive(:lookup).with(room.id).and_return(nil)
        @player.visited?(room).should be false

        @dungeon_map.should_receive(:put).with(room, @room)
        @player.enter_room(room)

        @dungeon_map.should_receive(:lookup).with(room.id).and_return(room)
        @player.visited?(room).should be true
      end
    end

    context 'and be able to get out of dead ends' do
      it 'should remember previous room' do
        @dungeon_map.should_receive(:lookup_entrance_to).with(@room.id).and_return(@room)
        @player.previous_room.should be @room
      end
    end

    #it 'should go back to previous room if there are no exits'

    #it 'should go back to previous room if all exits are visited'
  end

  context 'in order to recognize defeat' do
    it 'should know if all paths are explored' do
      @dungeon_map.should_receive(:unvisited_exits).and_return([1])
      @player.result.should_not eq :lost
      @dungeon_map.should_receive(:unvisited_exits).and_return([])
      @player.result.should eq :lost
    end
  end
end
