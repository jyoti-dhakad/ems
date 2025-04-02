# -*- encoding: utf-8 -*-
# stub: activeadmin-index_as_calendar 0.0.13 ruby lib

Gem::Specification.new do |s|
  s.name = "activeadmin-index_as_calendar".freeze
  s.version = "0.0.13"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["ByS Sistemas de Control".freeze]
  s.date = "2017-08-19"
  s.description = "Adds support to show resources indexes as calendar in ActiveAdmin using fullCalendar JQuery plugin".freeze
  s.email = ["info@bys-control.com.ar".freeze]
  s.homepage = "https://github.com/bys-control/activeadmin-index_as_calendar".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.4.10".freeze
  s.summary = "Adds support to show resources indexes as calendar in ActiveAdmin".freeze

  s.installed_by_version = "3.4.10" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<rails>.freeze, [">= 4"])
  s.add_runtime_dependency(%q<activeadmin>.freeze, [">= 0"])
  s.add_runtime_dependency(%q<momentjs-rails>.freeze, [">= 0"])
  s.add_runtime_dependency(%q<fullcalendar-rails>.freeze, ["~> 3.1"])
  s.add_development_dependency(%q<sqlite3>.freeze, ["~> 0"])
end
