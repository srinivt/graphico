require 'graphico'
include Graphico

describe "Graph" do
  before(:each) do
    @a, @b, @c, @d = Node.new('a'), Node.new('b'), Node.new('c'), Node.new('d')
    @g = Graph.new
  end
  
  it "should create a node" do
    n = Node.new("label")
    n.label.should == "label"
  end

  # TODO: Should graph be undirected or edges?
  it "should create an edge between nodes" do
    e = Edge.new(@a, @b)
    e.end_points.sort { |a, b| a.label <=> b.label }.should == [@a, @b]
  end

  it "should create an undirected graph and edges should be bidirectional" do
    g = Graph.new do |r|      
      r.nodes = [ @a, @b, @c ]
      r.edges = [ [@a, @b], [@a, @c], [@c, @b] ]
    end
    
    g.directed.should == false
    
    g.edge?(@b, @c).should == true
    g.edge?(@c, @b).should == true
  end

  it "should create a directed graph and edges should be unidirectional" do
    edge = Edge.new(@c, @d)
    
    g = Graph.new do |r|
      r.directed = true
      r.nodes = [ @a, @b, @c, @d ]
      r.edges = [ [@a, @b], [@a, @c], [@c, @b], edge ]
    end
    
    g.directed.should == true
    
    # TODO: Should node labels be symbols instead?
    g.edge?(@b, @c).should == false
    g.edge?(@c, @b).should == true
    g.edge?(@c, @d).should == true
  end
  
  it "should be able to add a node" do
    @g.nodes.size.should == 0
    
    @g.add_node(Node.new("a"))
    @g.nodes.size.should == 1
  end
  
  it "should not add duplicate edges in undirected graphs" do
    @g.nodes += [@a, @b]
    @g.edges << [@a, @b]
    @g.edges << Edge.new(@b, @a)
    
    @g.edges.size.should == 1
  end
  
  it "should be able to add a node" do
    @g.nodes.size.should == 0
    
    @g.add_node(Node.new("a"))
    @g.nodes.size.should == 1
    @g.nodes.collect(&:label).should == ["a"]
  end
  
  it "should be able to add an edge in directed graph" do
    g = Graph.new { |g| g.nodes = [@a, @b] ; g.directed = true }
    g.edges.size.should == 0
    
    g.add_edge([@a, @b])
    g.edges.size.should == 1
    
    g.add_edge([@b, @a])
    g.edges.size.should == 2
  end
  
  it "should not add duplicate nodes" do
    @g.nodes << @a
    @g.nodes.size.should == 1
    
    @g.add_node(@a)
    @g.nodes.size.should == 1
  end
    
  it "should not add an edge between nodes not in graph" do
    lambda { @g.add_edge(@a, @b) }.should raise_error(Graphico::InvalidEdge)
  end
  
  it "should be non-multiedged by default" do
    @g.allow_dup_edges.should == false
  end
  
  context "allow_dup_edges" do
    before(:each) do
      @g.nodes = [@a, @b]
      @g.allow_dup_edges = true
    end
    
    it "should allow adding dup edges in an allow_dup_edge undirected graph" do
      @g.directed.should == false
      @g.add_edge(@a, @b)
      @g.add_edge(@b, @a)
      @g.edges.size.should == 2
    end
  
    it "should allow adding dup edges in an allow_dup_edge directed graph" do
      @g.directed = true
      @g.add_edge(@a, @b)
      2.times { @g.add_edge(@b, @a) }
      @g.edges.size.should == 3
    end
  end
  
  it "should return false for edges? query for vertices not present in the graph" do
    @g.edge?(Node.new('a'), Node.new('b')).should == false
  end
  
  it "should clear the edges upon resetting the nodes" do
    @g.nodes = [@a, @b, @c]; @g.edges = [[@a, @b], [@b, @c]]
    @g.edges.size.should == 2
    
    @g.nodes = [@b, @c]
    @g.edges.size.should == 0
  end
  
  it "should iterate over the edges" do
    @g.nodes = [@a, @b, @c]; @g.edges = [[@a, @b], [@b, @c]]
    i = 0
    
    @g.edges.each { |e| i += 1 }
    i.should == 2
  end
  
  it "should create weighted graph"
  
  it "should delete corresponding edges on deleting a node"
  
  it "should return incident edges on a node on an undirected graph"
  
  it "should return incident edges on a node on a directed graph"
  
  it "should return degree of a node in an undirected graph"
  
  it "should return in-degree of a node in an directed graph" 
  
  it "should return out-degree of a node in an directed graph"
  
end

