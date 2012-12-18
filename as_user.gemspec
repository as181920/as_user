# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "as_user/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "as_user"
  s.version     = AsUser::VERSION
  s.authors     = ["Andersen Fan"]
  s.email       = ["as181920@hotmail.com"]
  s.homepage    = "https://github.com/as181920/as_user"
  s.summary     = "basic user handling and authentication solution for rails"
  s.description = "the most basic features"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc","CHANGELOG.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.9"
  s.add_dependency "bcrypt-ruby", "~> 3.0"
  s.add_dependency "pg"

  s.add_development_dependency "factory_girl_rails"
end

