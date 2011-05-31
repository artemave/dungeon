require './spec/spec_helper'
require 'client/player'
require 'client/dungeon'

describe 'adventure game' do
  before do
    @player = Player.new
    @dungeon = Dungeon.new

    # dungeon:
    # 1 - 2 - 3
    #     |   |
    #    *4*- 5
    Dupe.create :room, exits: [2]
    Dupe.create :room, exits: [1,3,4]
    Dupe.create :room, exits: [2,5]
    Dupe.create :room, type: :treasure_chamber, exits: [2,5]
    Dupe.create :room, exits: [3,4]
  end

  it 'starts with player entering dungeon' do
    @player.enter(@dungeon)

    @player.dungeon.should be @dungeon
    @player.current_room.id.should be @dungeon.entrance.id
  end

  it 'consists of player exploring dungeon by visiting rooms' do
    @player.enter(@dungeon)
    @player.next_room!.id.should eq 2
    @player.next_room!.id.should eq 3
    @player.next_room!.id.should eq 5
    @player.next_room!.id.should eq 4
    @player.next_room!.id.should eq 5
    @player.next_room!.id.should eq 3
    @player.next_room!.id.should eq 2
    @player.next_room!.id.should eq 1
    @player.next_room!.should eq nil
  end

  it 'is won when player found treasure chamber' do
    @player.enter(@dungeon)

    @player.next_room!
    @player.next_room!
    @player.next_room!
    @player.next_room!
    @player.result.should eq :won
  end

  it 'is lost if player has not found treasure chamber' do
    @player.enter(@dungeon)
    treasure_chamber = Dupe.find(:room) { |r| r.type == :treasure_chamber }
    treasure_chamber.stub(:type).and_return(:room)

    9.times { @player.next_room! }
    @player.result.should eq :lost
  end
end
