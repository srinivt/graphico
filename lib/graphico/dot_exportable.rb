module DotExportable
  def to_dot(file = 'graph')
    dot = header + export_nodes + export_edges + tail
    File.open(file, 'w') { |f| f.write(dot) }
  end
  
  def header
    (self.directed? ? "di" : '') + "graph graphico_graph {\n"
  end
  
  def tail
    "}\n"
  end
  
  def export_nodes
    nodes_dot = ''
    self.nodes.each do |n|
      nodes_dot += <<-NODE
      #{n.label} [
          fontsize = 12,
          label = #{n.label}
      ]\n
      NODE
    end
    nodes_dot
  end
  
  def export_edges
    edges_dot = ''
    sep = self.directed? ? '->' : '--'
    self.edges.each do |e|
      edges_dot << "#{e.head.label} #{sep} #{e.tail.label}\n"
    end
    edges_dot
  end
  
  def to_jpeg(file = 'graph')
    fmt = "jpg"
    file_with_ext = "#{file}.#{fmt}"
    dot = "#{file}.dot"
    to_dot(dot)
    `dot -T#{fmt} #{dot} -o #{file_with_ext}`
  end
end