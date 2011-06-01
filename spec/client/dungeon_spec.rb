require './spec/spec_helper'
require 'client/dungeon'
require 'client/room'

describe Dungeon do
  before do
    @dungeon = Dungeon.new
    @room = double('Room', id: 1, exits: [2])
  end

  it "should have entrance" do
    Room.should_receive(:find).with(:one, from: '/entrance.xml').and_return(@room)
    entrance = @dungeon.entrance

    entrance.id.should be 1
    entrance.exits.should eq [2]
  end

  it "should reveal rooms" do
    Room.should_receive(:find).with(1).and_return(@room)
    room = @dungeon.enter_room(1)

    room.id.should eq 1
    room.exits.should eq [2]
  end

  it "should keep track of revealed rooms" do
    Room.stub(:find).and_return(@room)
    @dungeon.enter_room(1)
    @dungeon.visited_rooms.should == { 1 => @room }
  end
end
