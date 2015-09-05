# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cap_expect/version'

Gem::Specification.new do |spec|
  spec.name          = "cap-expect"
  spec.version       = CapExpect::VERSION
  spec.authors       = ["Thomas Leishman"]
  spec.email         = ["tleish@gmail.com"]
  spec.licenses      = ['MIT']

  spec.summary       = %q{Capistrano Expect Tool.}
  spec.description   = %q{Runs custom expect scripts using Capistrano variables.}
  spec.homepage      = "https://github.com/tleish/cap_expect"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files        = Dir.glob("{exe,lib}/**/*") + %w(README.md)
  spec.bindir        = "exe"
  spec.executables   = Dir.glob("exe/*").map(&File.method(:basename))
  spec.require_path = 'lib'

  spec.add_dependency "thor", "~> 0.19.0"
  spec.add_dependency "highline", "~> 1.7.1"
  spec.add_dependency "capistrano", "~> 2.14.2"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
end
