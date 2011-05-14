# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "graphico/version"

Gem::Specification.new do |s|
  s.name        = "graphico"
  s.version     = Graphico::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Srinivasan Thirunarayanan"]
  s.email       = ["srinivt@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{A Ruby-based graph algorithms package}
  s.description = %q{Slated to include DFS, BFS, shortest path search, topological sorting, Network flows and more}

  s.rubyforge_project = "graphico"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
