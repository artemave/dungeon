require './spec/spec_helper'
require 'client/player'

describe Player do
  before do
    @dungeon = double('Dungeon')
    @dungeon_map = double('DungeonMap', put: nil, start: nil)

    @player = Player.new
    @player.stub(:dungeon).and_return(@dungeon)
    @player.stub(:dungeon_map).and_return(@dungeon_map)

    @room = double('Room', id: 1, exits: [2], type: :room)
    @next_room = double('Room', id: 2)
  end

  it 'should be able to enter the dungeon' do
    @dungeon.should_receive(:entrance).and_return(@room)
    @player.enter(@dungeon)
    @player.current_room.should be @room
  end
  
  it 'should be able to move to next room' do
    @player.ai.should_receive(:suggest_next_room).and_return(2)
    @player.dungeon.should_receive(:get_room).with(2).and_return(@next_room)

    @player.next_room!
    @player.current_room.should be @next_room
  end

  it "should remember visited rooms" do
    #when entering dungeon
    @dungeon.stub(:entrance).and_return(@room)
    @player.dungeon_map.should_receive(:start).with(@room)
    @player.enter(@dungeon)

    #when visiting rooms
    @player.ai.stub(:suggest_next_room).and_return(2)
    @player.dungeon.stub(:get_room).and_return(@next_room)
    @player.dungeon_map.should_receive(:put).with(@next_room, @room)
    @player.next_room!
  end

  it 'should be able to see if he/she has won' do
    treasure_chamber = double('Room')

    @player.should_receive(:current_room).and_return(treasure_chamber)
    treasure_chamber.should_receive(:type).and_return(:treasure_chamber)
    @player.result.should eq :won
  end

  it "should be able to recognize defeat" do
    @player.stub(:current_room).and_return(@room)
    @player.ai.should_receive(:suggest_next_room).and_return(nil)
    @player.result.should eq :lost
  end
end
