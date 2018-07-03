$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "dub_thee/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "dub_thee"
  s.version     = DubThee::VERSION
  s.authors     = [""]
  s.email       = [""]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of DubThee."
  s.description = "TODO: Description of DubThee."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.2.0"

  s.add_development_dependency "sqlite3"
end
