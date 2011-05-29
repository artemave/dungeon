require 'tree'

class DungeonMap
  def put(room)
    if room.entrance and not mapped?(room)
      parent_node = search_node(room.entrance.id)
      parent_node << Tree::TreeNode.new(room.id.to_s, room)
    else # dungeon entrance -> root node
      @tree = Tree::TreeNode.new(room.id.to_s, room)
    end
  end

  def visited_rooms
    [].tap do |visited_room_ids|
      @tree.each do |n|
        visited_room_ids << n.content.id
      end
    end
  end

  private

    def mapped?(room)
      !!search_node(room.id)
    end

    def search_node(name)
      node = nil
      @tree.each do |n|
        node = n if n.name == name.to_s
        break if node
      end
      node
    end
end
