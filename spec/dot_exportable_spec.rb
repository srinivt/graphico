def dot_exists?
  begin 
    %x{ dot -V 2&>1 >> /dev/null }
    return true
  rescue Errno::ENOENT
    puts "Skipping dot_export specs (dot does not exist, install graphviz)"
    return false
  end
end

describe "Dot Exportable", :if => dot_exists? do
  context "dot_export" do
    before(:each) do
      `rm *.jpg *.dot`
      @a, @b, @c, @d = Node.new('a'), Node.new('b'), Node.new('c'), Node.new('d')
      @g = Graph.new
    end
    
    it "should export a graph to a dot" do
      File.exists?('spec_graph.dot').should == false
      File.exists?('spec_graph.jpg').should == false
      
      @g.allow_dup_edges = true
      @g.nodes = [@a, @b, @c]; @g.edges = [[@a, @b], [@b, @c], [@b, @c]]
      @g.to_jpeg('spec_graph')
      
      File.exists?('spec_graph.dot').should == true
      File.exists?('spec_graph.jpg').should == true
    end
    
    it "should export a directed graph to a dot" do
      File.exists?('spec_digraph.dot').should == false
      File.exists?('spec_digraph.jpg').should == false
      
      @g.allow_dup_edges = true; @g.directed = true
      @g.nodes = [@a, @b, @c]; @g.edges = [[@a, @b], [@b, @c], [@b, @c]]
      @g.to_jpeg('spec_digraph')
      
      File.exists?('spec_digraph.dot').should == true
      File.exists?('spec_digraph.jpg').should == true
    end
  end
end