require './spec/spec_helper'
require 'client/ai'

describe AI::NoBrainer do
  before do
    @player = double('Player', dungeon_map: double('DungeonMap'))
    @ai = AI::NoBrainer.new(@player)
  end

  context "given there are unvisited exits from a room" do
    it "should choose either of them" do
      @ai.player.should_receive(:current_room).and_return(double('Room', id: 2, exits: [1,3,4,5]))
      @ai.player.dungeon_map.should_receive(:visited_rooms).and_return([1,2,5])

      @ai.suggest_next_room.should be_in [3,4]
    end
  end

  context "given all exits from a room are visited" do
    it "should choose previous room" do
      @ai.player.should_receive(:current_room).and_return(double('Room', id: 2, exits: [1,3,4,5]))
      @ai.player.dungeon_map.should_receive(:visited_rooms).and_return([1,2,3,4,5])
      @ai.player.dungeon_map.should_receive(:lookup_entrance_to).with(2).and_return(1)

      @ai.suggest_next_room.should eq 1
    end
  end

  context "given all rooms are visited" do
    it "should give up" do
      @ai.player.should_receive(:current_room).and_return(double('Room', id: 1, exits: [2]))
      @ai.player.dungeon_map.should_receive(:visited_rooms).and_return([1,2,3,4,5])
      @ai.player.dungeon_map.should_receive(:lookup_entrance_to).with(1).and_return(nil)
      
      @ai.suggest_next_room.should be nil
    end
  end
end
