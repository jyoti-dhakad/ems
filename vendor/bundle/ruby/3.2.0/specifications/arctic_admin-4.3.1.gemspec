# -*- encoding: utf-8 -*-
# stub: arctic_admin 4.3.1 ruby lib

Gem::Specification.new do |s|
  s.name = "arctic_admin".freeze
  s.version = "4.3.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "changelog_uri" => "https://github.com/cprodhomme/arctic_admin/releases", "source_code_uri" => "https://github.com/cprodhomme/arctic_admin" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Cl\u00E9ment Prod'homme".freeze]
  s.date = "2024-04-09"
  s.description = "A responsive theme for Active Admin".freeze
  s.homepage = "https://github.com/cprodhomme/arctic_admin".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.4.10".freeze
  s.summary = "Arctic Admin theme for ActiveAdmin".freeze

  s.installed_by_version = "3.4.10" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_development_dependency(%q<bundler>.freeze, ["~> 1.5"])
  s.add_development_dependency(%q<rake>.freeze, [">= 0"])
  s.add_runtime_dependency(%q<activeadmin>.freeze, [">= 1.1.0", "< 4.0"])
  s.add_runtime_dependency(%q<font-awesome-sass>.freeze, ["~> 6.0"])
end
