require './spec/spec_helper'
require 'client/dungeon_map'

describe DungeonMap do
  context 'in order for player to be able to track his path' do
    it 'should allow to start map with entrance'
    it 'should allow to put room on the map'
    it 'should allow to lookup room'
    it 'should allow to lookup entrance to particular room'
  end

  context 'in order for player to be able to recognize defeat' do
    it 'should keep track of unvisited exits'
  end
end
