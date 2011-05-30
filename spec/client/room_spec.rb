require './spec/spec_helper'
require 'client/room'

describe Room do
  it "should have exits" do
    pending 'this is coming from server'
  end

  it "should have id" do
    pending 'this is coming from server'
  end

  it "should allow to set/retreive entrance" do
    @room = Room.new
    @room.should respond_to(:entrance)
    @room.should respond_to('entrance=')
  end
end
