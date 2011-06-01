require './spec/spec_helper'
require 'client/player'

describe Player do
  before do
    @dungeon = double('Dungeon', visited_rooms: {})

    @player = Player.new
    @player.stub(:dungeon).and_return(@dungeon)

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
    @player.dungeon.should_receive(:enter_room).with(2).and_return(@next_room)

    @player.next_room!
    @player.current_room.should be @next_room
  end

  context 'in order to not get lost' do
    before do
      @player.stub(:current_room).and_return(@room)
      @player.ai.stub(:suggest_next_room).and_return(2)
      @player.dungeon.stub(:enter_room).and_return(@next_room)
    end

    it "should remember visited rooms" do
      @player.dungeon.should_receive(:visited_rooms).and_return(1 => @room)
      @player.visited_rooms.should == { 1 => @room }
    end

    it "should remember room entrance" do
      @next_room.should_receive('entrance=').with(@room)
      @player.next_room!
    end

    it "should only save entrance once" do
      @next_room.should_receive('entrance=').once.with(@room)
      @player.next_room!
      @player.stub(:visited_rooms).and_return(2 => @next_room)
      @player.next_room!
    end
  end

  it 'should win when in treasure chamber' do
    treasure_chamber = double('Room')

    @player.should_receive(:current_room).and_return(treasure_chamber)
    treasure_chamber.should_receive(:type).and_return(:treasure_chamber)
    @player.result.should eq :won
  end

  it "should lose when there is nowhere else to go" do
    @player.stub(:current_room).and_return(@room)
    @player.ai.should_receive(:suggest_next_room).and_return(nil)
    @player.result.should eq :lost
  end
end
