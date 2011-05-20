require 'client/player'
require 'client/dungeon'
require 'client/room'

describe Player do
  before do
    @dungeon = Dungeon.new
  end

  context 'in order to start the game' do
    it 'should enter the dungeon' do
      entrance = @dungeon.enter
      entrance.should be_an_instance_of(Room)
    end
  end

  context 'in order to win the game' do
    it 'should find the treasure chamber'
  end

  context 'in order to find the treasure chamber' do
    it 'should move to other rooms'
  end

  context 'in order to move to other rooms' do
    it 'should follow exit from the current room'
  end

  context 'in order to to try different routes' do
    it 'should be able to go back to the previous room'
  end

  context 'in order to not loop endlessly' do
    it 'should not follow visted exits'
  end

  context 'in order to complete a certain path' do
    it 'should not go back from a room before all exits are visited'
  end

  it 'should admit defeat if there are no possible moves'

end
