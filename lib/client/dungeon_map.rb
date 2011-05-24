require 'tree'

class DungeonMap
  def start(entrance)
    @tree = Tree::TreeNode.new(entrance.id.to_s, entrance)
  end

  def put(room, prev_room)
    parent_node = search_node(prev_room.id)
    parent_node << Tree::TreeNode.new(room.id.to_s, room)
  end

  def lookup(room_id)
    node = search_node(room_id) or return
    node.content
  end

  def lookup_entrance_to(room_id)
    node = search_node(room_id) or return
    node.parent && node.parent.content
  end

  private

    def search_node(name)
      node = nil
      @tree.each do |n|
        node = n if n.name == name.to_s
        break if node
      end
      node
    end
end
