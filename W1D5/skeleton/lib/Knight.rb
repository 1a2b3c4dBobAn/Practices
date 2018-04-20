require_relative '00_tree_node.rb'

class KnightPathFinder
  attr_reader :start_pos, :move_tree, :visited_pos

  DIFF = [[2,1],
          [1,2],
          [-1,2],
          [-2,1],
          [-2,-1],
          [-1,-2],
          [1,-2],
          [2,-1]]

  def self.valid_moves(start)
    new_pos = DIFF.map do |pos|
      [start[0] + pos[0], start[1] + pos[1]]
    end
    new_pos.select {|pos| KnightPathFinder.valid_pos?(pos)}
  end

  def self.valid_pos?(pos)
    pos.all? {|el| el>=0 && el<8}
  end

  def initialize(start_pos = [0,0])
    @start_pos = start_pos
    @visited_pos = [start_pos]
    @move_tree = build_move_tree

  end

  def find_path(final_pos)
    trace_path_back(@move_tree.dfs(final_pos)) if KnightPathFinder.valid_pos?(final_pos)
  end

  def trace_path_back(node)
    path = []
    until node == move_tree
      path.unshift(node.value)
      node = node.parent
    end
    path.unshift(node.value)
    path
  end

  def new_move_positions(pos)
    KnightPathFinder.valid_moves(pos).reject {|loc| @visited_pos.include?(loc)}
  end

  def build_move_tree
    first = PolyTreeNode.new(start_pos)
    node_arr = [first]

    until node_arr.length==0
      node = node_arr.shift

      poss_pos = new_move_positions(node.value)

      poss_pos.each do |node_pos|
        new_node = PolyTreeNode.new(node_pos)
        node.add_child(new_node)
        new_node.parent = node

        node_arr.push(new_node)
        @visited_pos << node_pos

      end
    end

    first


    # move_pos = new_move_positions(start_pos)
    # move_pos.each do |pos|
    #   @visited_pos << pos
    #   pos_node = PolyTreeNode.new(pos)
    #   pos_node.children

  end








end
