module Graphico
  class Edge
    attr_accessor :head, :tail
    
    def initialize(from, to)
      @head = from
      @tail = to
    end
    
    def end_points
      [head, tail]
    end
    
    def inspect
      "#<Edge: #{head.label} -> #{tail.label}>"
    end
  end
end
