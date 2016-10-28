$:.push File.expand_path("../lib", __FILE__)

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "lato_core"
  s.version     = "1.1.3"
  s.authors     = ["Gregorio Galante, Antonio Dal Cin, Riccardo Zanutta"]
  s.email       = ["gregogalante@gmail.com"]
  s.homepage    = "https://github.com/LatoTeam/lato_core"
  s.summary     = "Lato module for basic functions"
  s.description = "Lato module for basic functions"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib,lang}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails"
  s.add_dependency "bcrypt"

end
