module DotExportable
  def to_dot(file = 'graph')
    dot = header + export_nodes + export_edges + tail
    File.open(file, 'w') { |f| f.write(dot) }
  end
  
  def header
    "#{"di" if directed?}graph graphico_graph {\n"
  end
  
  def tail
    "}\n"
  end
  
  def export_nodes
    nodes.inject('') do |s, n|
      s + <<-NODE
      #{n.label} [
          fontsize = 12,
          label = #{n.label}
      ]\n
      NODE
    end
  end
  
  def export_edges
    edges_dot = ''
    sep = directed? ? '->' : '--'
    edges.each do |e|
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