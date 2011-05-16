module Graphico
  class InvalidArgumentError < RuntimeError; end
  
  class Graph
    include DotExportable
    
    attr_accessor :directed, :allow_dup_edges
    attr_reader :nodes, :edges
    
    def initialize(&block)
      @directed = @allow_dup_edges = false
      @nodes = []
      @edges = EdgeSet.new(self)

      yield(self) if block_given?
    end
    
    def nodes=(set)
      set.each { |n| add_node(n) }
      
      # Reset the edges
      @edges = EdgeSet.new(self)  
    end
    
    def has_node?(n)
      not self.nodes.index(n).nil?
    end
    
    def add_node(n)
      (@nodes << n) unless @nodes.index(n)
    end
    
    def edges=(set)
      @edges.add_multiple(set)
    end
    
    # Add an edge to graph.
    # Examples:
    #   g.add_edge(node1, node2)
    #   g.add_edge([node1, node2])
    #   g.add_edge(Edge.new(node1, node2))
    def add_edge(*e)
      raise InvalidArgumentError if e.size > 2
      
      e = [e] if e.size == 2
      @edges.add(e[0])
    end
    
    def directed?
      @directed
    end
    
    def allow_dup_edges?
      @allow_dup_edges
    end
    
    def edge?(a, b)
      directed? ? @edges.exists?(a, b) : 
        (@edges.exists?(a, b) or @edges.exists?(b, a))
    end   
  end
end