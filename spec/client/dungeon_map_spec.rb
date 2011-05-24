require './spec/spec_helper'
require 'tree'
require 'client/dungeon_map'

describe DungeonMap do
  before do
    @map = DungeonMap.new
    @map.instance_variable_set(:@tree, Tree::TreeNode.new(1))
  end

  context 'in order for player to be able to track his path' do
    it 'should allow to start map with entrance' do
      entrance = double('Room', :id => 1)

      @map.start(entrance)

      tree = @map.instance_variable_get(:@tree)
      tree.should be_is_root
      tree.name.should == entrance.id.to_s
      tree.content.should be entrance
    end

    it 'should allow to put room on the map' do
      entrance = double('Room', :id => 1)
      @map.instance_variable_set(:@tree, Tree::TreeNode.new("1", entrance))
      room1 = double('Room', :id => 2)
      room2 = double('Room', :id => 3)

      @map.put(room1, entrance)
      @map.put(room2, room1)

      tree = @map.instance_variable_get(:@tree)
      tree[room1.id.to_s][room2.id.to_s].content.should be room2
    end

    it 'should allow to lookup room'
    it 'should allow to lookup entrance to particular room'
  end

  context 'in order for player to be able to recognize defeat' do
    it 'should keep track of unvisited exits'
  end
end
