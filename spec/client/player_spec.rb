require './spec/spec_helper'
require 'client/player'

describe Player do
  before do
    @dungeon = double('Dungeon')
    @dungeon_map = double('DungeonMap', put: nil, visited_rooms: [])

    @player = Player.new
    @player.stub(:dungeon).and_return(@dungeon)
    @player.stub(:dungeon_map).and_return(@dungeon_map)

    @room = double('Room', id: 1, exits: [2], type: :room)
    @next_room = double('Room', id: 2, 'entrance=' => nil)
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

  context 'in order to not get lost' do
    describe 'when entering dungeon' do
      before do
        @dungeon.stub(:entrance).and_return(@room)
      end

      it 'should remember entrance' do
        @player.dungeon_map.should_receive(:put).with(@room)
        @player.enter(@dungeon)
      end

      it "should not remember room entrance" do
        @room.should_not_receive('entrance=')
        @player.enter(@dungeon)
      end
    end

    describe 'when visiting rooms' do
      before do
        @player.stub(:current_room).and_return(@room)
        @player.ai.stub(:suggest_next_room).and_return(2)
        @player.dungeon.stub(:get_room).and_return(@next_room)
      end

      it "should remember visited rooms" do
        @player.dungeon_map.should_receive(:put).with(@next_room)
        @player.next_room!
      end

      it "should remember room entrance" do
        @next_room.should_receive('entrance=').with(@room)
        @player.next_room!
      end

      it "should only save entrance once" do
        @next_room.should_receive('entrance=').once.with(@room)
        @player.next_room!
        @player.should_receive(:visited_rooms).and_return([2])
        @player.next_room!
      end
    end
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
