lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'groonga_dev_search/version'

Gem::Specification.new do |spec|
  spec.name          = "groonga_dev_search"
  spec.version       = GroongaDevSearch::VERSION
  spec.authors       = ["Masafumi Yokoyama"]
  spec.email         = ["yokoyama@clear-code.com"]
  spec.description   = %q{The full-text search system for groonga-dev (The mailing list of the Groonga community in Japanese).}
  spec.summary       = %q{Full-Text Search system for groonga-dev}
  spec.homepage      = "http://myokoym.net/groonga_dev_search/"
  spec.license       = "LGPLv2.1+"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) {|f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency("rroonga", ">= 5.0.0")
  spec.add_runtime_dependency("mail")
  spec.add_runtime_dependency("thor")
  spec.add_runtime_dependency("parallel")
  spec.add_runtime_dependency("sinatra")
  spec.add_runtime_dependency("sinatra-contrib")
  spec.add_runtime_dependency("sinatra-cross_origin")
  spec.add_runtime_dependency("padrino-helpers")
  spec.add_runtime_dependency("kaminari")
  spec.add_runtime_dependency("kaminari-sinatra")
  spec.add_runtime_dependency("haml")
  spec.add_runtime_dependency("launchy")
  spec.add_runtime_dependency("racknga")

  spec.add_development_dependency("bundler")
  spec.add_development_dependency("rake")
end
