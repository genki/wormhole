Gem::Specification.new do |s|
  s.name = %q{wormhole}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Genki Takiuchi"]
  s.autorequire = %q{}
  s.date = %q{2008-07-02}
  s.description = %q{The utility library for making a wormhole on the stack frame.}
  s.email = %q{genki@s21g.com}
  s.extra_rdoc_files = ["README", "ChangeLog"]
  s.files = ["README", "ChangeLog", "Rakefile", "test/test_helper.rb", "test/wormhole_test.rb", "lib/wormhole.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://wormhole.rubyforge.org}
  s.rdoc_options = ["--title", "wormhole documentation", "--charset", "utf-8", "--opname", "index.html", "--line-numbers", "--main", "README", "--inline-source", "--exclude", "^(examples|extras)/"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{wormhole}
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{The utility library for making a wormhole on the stack frame.}
  s.test_files = ["test/test_helper.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
    else
    end
  else
  end
end
