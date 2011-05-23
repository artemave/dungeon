require 'tree'

class Player
  class DungeonMap
    def put(room, prev_room)
      if not @tree
        @tree = Tree::TreeNode.new(room.id, room)
      elsif not visited?(room)
        @tree[prev_room.id] << Tree::TreeNode.new(room.id, room)
      end
    end

    def lookup(room_id)
      node = search_node(room_id) or return
      node.content
    end

    def lookup_entrance_to(room_id)
      node = search_node(room_id) or return
      node.parent && node.parent.content
    end

    def reset
      @tree = nil
    end

    private
      def search_node(name)
        return if not @tree

        node = nil
        @tree.each do |n|
          node = n.name == name && n
          break if node
        end
        node
      end
  end

  def initialize
    @dungeon_map = DungeonMap.new
  end

  def enter_dungeon(dungeon)
    @dungeon = dungeon
    @dungeon_map.reset
    enter_room(@dungeon.entrance)
  end

  def enter_room(room)
    prev_room = current_room

    @current_room = if room.kind_of?(Integer)
                      @dungeon_map.lookup(room) || @dungeon.reveal_room(room)
                    else
                      room
                    end
    @dungeon_map.put(current_room, prev_room)
  end

  attr_reader :current_room

  def previous_room
    @dungeon_map.lookup_entrance_to(current_room.id)
  end

  def current_exits
    current_room.exits
  end

  def result
    case current_room.type
    when :treasure_chamber
      :won
    end
  end

  def visited?(room)
    !!@dungeon_map.lookup(room.id)
  end

end
