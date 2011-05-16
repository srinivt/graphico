module Graphico
  class InvalidEdge < RuntimeError; end
  
  class EdgeSet
    attr_reader :set
    
    def initialize(g)
      @graph = g
      @set = Array.new
    end
    
    def add(e)
      e = Edge.new(*e) if e.is_a?(Array)
      
      raise Graphico::InvalidEdge unless (@graph.has_node?(e.head) and @graph.has_node?(e.tail))
      
      if @graph.allow_dup_edges?
        @set << e
      else
        @set << e unless @graph.edge?(e.head, e.tail)
      end
      
      @graph
    end
    
    def add_multiple(edges)
      edges.each { |e| add(e) } 
      
      @graph
    end
    
    def each(&block)
      @set.each { |e| yield(e) }
    end
    
    def exists?(a, b)
      @set.any? { |e| e.end_points == [a, b] }
    end
    
    def size
      @set.size
    end
    
    alias :<< :add
  end
end