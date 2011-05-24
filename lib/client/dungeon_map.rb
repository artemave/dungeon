require 'tree'

class DungeonMap
  def start(entrance)
    @tree = Tree::TreeNode.new(entrance.id, entrance)
  end

  def put(room, prev_room)
    @tree[prev_room.id] << Tree::TreeNode.new(room.id, room)
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
      return if not @tree

      node = nil
      @tree.each do |n|
        node = n.name == name && n
        break if node
      end
      node
    end
end
