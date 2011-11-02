# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "web-facter/version"

Gem::Specification.new do |s|
  s.name        = "web-facter"
  s.version     = WebFacter::VERSION
  s.authors     = ["Gareth Rushgrove"]
  s.email       = ["gareth@morethanseven.net"]
  s.homepage    = "https://github.com/garethr/web-facter"
  s.summary     = %q{Display Facter information as JSON over HTTP}
  s.description = %q{Daemon which serves information from the facter gem as JSON over HTTP}

  s.rubyforge_project = "web-facter"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "rack"
  s.add_runtime_dependency "facter"
  s.add_runtime_dependency "parseconfig"

  s.add_development_dependency "test-unit"
  s.add_development_dependency "rack-test"
  s.add_development_dependency "mocha"
end
