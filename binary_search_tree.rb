class BinarySearchTree
  # Hashを継承しているのは、directionを使ってleft, rightに対して共通メソッドを使えるようにしたかっただけ
  class Node < Hash
    def initialize(value, options = {})
      self[:value]  = value
      self[:parent] = options[:parent]
      self[:left]   = options[:left]
      self[:right]  = options[:right]
    end

    def set_child(node, direction)
      self[direction] = node
      node[:parent]   = self
    end

    # 親等の近い先祖から順に配列で返す
    def ancestors
      return [] if self[:parent].nil?
      [self[:parent], self[:parent].ancestors].flatten
    end
  end

  def initialize(values = [])
    Array(values).each {|value| insert!(value)}
  end

  def insert!(value)
    return @root = Node.new(value) if @root.nil?
    insert_r(value, @root)
  end

  def lowest_common_ancestor(val1, val2)
    node1 = search(val1, @root) or return nil
    node2 = search(val2, @root) or return nil
    lca = (node1.ancestors & node2.ancestors).first
    lca.nil? ? nil : lca[:value]
  end

  private
  def insert_r(value, current)
    direction = get_direction(value, current[:value])
    return current.set_child(Node.new(value), direction) if current[direction].nil?
    insert_r(value, current[direction])
    #current[direction].nil? ? current.set_child(Node.new(value), direction) : insert_r(value, current[direction])
  end

  def search(value, current)
    return nil if current.nil?
    return current if current[:value] == value
    search(value, current[get_direction(value, current[:value])])
  end

  # valueは同値が現れない前提
  def get_direction(val, base)
    val < base ? :left : :right
  end

  public
  def debug
    debug_r(@root)
  end

  def debug_r(node)
    return nil if node.nil?
    puts "#{node[:value]} : ancestors => #{node.ancestors.map{|a| a[:value]}}"
    debug_r(node[:left])
    debug_r(node[:right])
  end
end
