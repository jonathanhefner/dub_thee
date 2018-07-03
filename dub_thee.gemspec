$:.push File.expand_path("lib", __dir__)

require "dub_thee/version"

Gem::Specification.new do |s|
  s.name        = "dub_thee"
  s.version     = DubThee::VERSION
  s.authors     = ["Jonathan Hefner"]
  s.email       = ["jonathan.hefner@gmail.com"]
  s.homepage    = "https://github.com/jonathanhefner/dub_thee"
  s.summary     = %q{Rails page titles via I18n}
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "yard", "~> 0.9"
end
