class PolyTreeNode

  def initialize(value, parent = nil)
    @value = value
    @parent = parent
    @children = []
  end

  def parent
    @parent
  end

  def children
    @children
  end

  def value
    @value
  end

  def parent=(node)
    if @parent == node
      return "Parent already exist."

    else
      @parent.children.delete(self) unless parent.nil?
      @parent = node
      @parent.children << self unless node.nil?
    end
  end

  def add_child(child_node)
    if @children.include?(child_node)
      return "Child already exists."
    else
      child_node.parent = self
    end
  end

  def remove_child(child_node)
    if child_node.parent == self
      child_node.parent = nil
    else
      raise "That's not my child."
    end
  end

  def dfs(target_value)
    if target_value == self.value
      return self
    else
      @children.each do |child|
        result = child.dfs(target_value)
        return result if result #&& (target_value == result.value)
      end
      nil
    end
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      temp = queue.shift
      return temp if temp.value == target_value
      queue += temp.children
    end
    nil
  end

end
