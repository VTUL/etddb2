# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "rails_code_qa"
  s.version = "0.5.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Nathan Humbert"]
  s.date = "2012-01-20"
  s.description = "This gem uses several different methods to help QA the code in your rails app"
  s.email = ["nathan.humbert+rcqa@gmail.com"]
  s.homepage = "http://github.com/nathanhumbert/rails_code_qa"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.11"
  s.summary = "Rails Code QA"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rcov>, ["= 0.9.9"])
      s.add_runtime_dependency(%q<flog>, ["= 2.5.1"])
      s.add_runtime_dependency(%q<flay>, ["= 1.4.2"])
      s.add_runtime_dependency(%q<simplecov>, ["~> 0.5.4"])
    else
      s.add_dependency(%q<rcov>, ["= 0.9.9"])
      s.add_dependency(%q<flog>, ["= 2.5.1"])
      s.add_dependency(%q<flay>, ["= 1.4.2"])
      s.add_dependency(%q<simplecov>, ["~> 0.5.4"])
    end
  else
    s.add_dependency(%q<rcov>, ["= 0.9.9"])
    s.add_dependency(%q<flog>, ["= 2.5.1"])
    s.add_dependency(%q<flay>, ["= 1.4.2"])
    s.add_dependency(%q<simplecov>, ["~> 0.5.4"])
  end
end
