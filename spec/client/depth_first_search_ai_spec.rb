require './spec/spec_helper'
require 'client/ai'

describe AI::DepthFirstSearch do
  before do
    @player = double('Player')
    @ai = AI::DepthFirstSearch.new(@player)
  end

  context "given there are unvisited exits from a room" do
    it "should choose first" do
      @ai.player.should_receive(:current_room).and_return(double('Room', id: 2, exits: [1,3,4,5]))
      @ai.player.should_receive(:visited_rooms).and_return(1 => nil, 2 => nil, 5 => nil)

      @ai.suggest_next_room.should be 3
    end
  end

  context "given all exits from a room are visited" do
    it "should choose previous room" do
      entrance = double('Room', id: 1, exits: [2])
      current_room = double('Room', id: 2, exits: [1,3,4,5])
      @ai.player.should_receive(:current_room).and_return(current_room)
      @ai.player.should_receive(:visited_rooms).and_return(1 => nil, 2 => nil, 3 => nil, 4 => nil, 5 => nil)
      current_room.should_receive(:entrance).and_return(entrance)

      @ai.suggest_next_room.should eq 1
    end
  end

  context "given all rooms are visited" do
    it "should give up" do
      current_room = double('Room', id: 1, exits: [2])
      @ai.player.should_receive(:current_room).and_return(current_room)
      @ai.player.should_receive(:visited_rooms).and_return(1 => nil, 2 => nil, 3 => nil, 4 => nil, 5 => nil)
      current_room.should_receive(:entrance).and_return(nil)
      
      @ai.suggest_next_room.should be nil
    end
  end
end
