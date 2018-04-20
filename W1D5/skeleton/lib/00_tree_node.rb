require 'byebug'

class PolyTreeNode

  attr_reader :parent, :children, :value

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(dad)
    parent.children.delete(self) if parent && parent != dad
    @parent = dad
    dad.children << self unless dad.nil? || parent.children.include?(self)

  end

  def remove_child(child)
    raise "Is not my child!" unless children.include?(child)
    child.parent = nil
  end

  # def inspect
  #   value
  # end

  def add_child(child)
    child.parent = self
  end

  def dfs(target)

    return self if value == target

    self.children.each do |child|
      rec = child.dfs(target)

      return rec if rec
    end
    nil

  end

  def bfs(target)

    node_arr = [self]

    until node_arr.length==0
      node = node_arr.shift
      if node.value == target
        return node
      end
      node_arr += node.children
    end
    nil

  end
end


















#
