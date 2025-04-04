# -*- encoding: utf-8 -*-
# stub: fullcalendar-rails 3.9.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "fullcalendar-rails".freeze
  s.version = "3.9.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["bokmann".freeze, "gr8bit".freeze]
  s.date = "2018-06-02"
  s.description = "FullCalendar is a fantastic jQuery plugin that gives you an event calendar with tons of great AJAX wizardry, including drag and drop of events.  I like having managed pipeline assets, so I gemified it.".freeze
  s.email = ["dbock@codesherpas.com".freeze, "niklas@bichinger.de".freeze]
  s.homepage = "https://github.com/bokmann/fullcalendar-rails".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.4.10".freeze
  s.summary = "A simple asset pipeline bundling for Ruby on Rails of the FullCalendar jQuery plugin.".freeze

  s.installed_by_version = "3.4.10" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<jquery-rails>.freeze, [">= 4.0.5", "< 5.0.0"])
  s.add_runtime_dependency(%q<jquery-ui-rails>.freeze, [">= 5.0.2"])
  s.add_runtime_dependency(%q<momentjs-rails>.freeze, [">= 2.9.0"])
  s.add_development_dependency(%q<rake>.freeze, ["~> 0"])
end
