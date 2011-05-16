# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "graphico/version"

Gem::Specification.new do |s|
  s.name        = "graphico"
  s.version     = Graphico::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Srinivasan Thirunarayanan"]
  s.email       = ["srinivt@gmail.com"]
  s.homepage    = "https://github.com/srinivt/graphico"
  s.summary     = %q{A Ruby-based graph algorithms package}
  s.description = %q{Slated to include DFS, BFS, shortest path search, topological sorting, Network flows and more}

  s.rubyforge_project = "graphico"
  
  s.requirements  = ['graphviz']
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_development_dependency("rspec") 
  s.post_install_message = <<-POST_INSTALL
Thanks for installing Graphico.

You can optionally export graphs to JPEG images, but you need the 
Graphviz package (http://www.graphviz.org/). 
POST_INSTALL
end