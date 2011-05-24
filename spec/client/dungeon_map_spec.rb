require './spec/spec_helper'
require 'client/dungeon_map'

describe DungeonMap do
  before do
    @map = DungeonMap.new
  end

  context 'in order for player to be able to track his path' do
    it 'should allow to start map with entrance' do
      entrance = double('Room', :id => 1)

      @map.start(entrance)

      tree = @map.instance_variable_get(:@tree)
      tree.should be_is_root
      tree.name.should be entrance.id
      tree.content.should be entrance
    end

    it 'should allow to put room on the map'
    it 'should allow to lookup room'
    it 'should allow to lookup entrance to particular room'
  end

  context 'in order for player to be able to recognize defeat' do
    it 'should keep track of unvisited exits'
  end
end
