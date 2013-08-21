load 'lib/strictures/version.rb'

spec = Gem::Specification.new do |s|
  s.name = 'strictures'
  s.version = Strictures::VERSION

  s.summary = %{
    Strictures is a ruby gem for defining requirements on objects.
  }.strip

  s.description = %{
    It's like Rails validations, say, or RSpec's argument matchers,
    but you can use them however you want to.

    To make this work, you need to be able to do three things:

    1. define rules for how your data should look
    2. check your data against those rules
    3. see the results, and use them in your code
  }.strip

  s.files = Dir['lib/**/*.rb'] + Dir['spec/**/*.rb'] + %w[
    README.md
    Rakefile
    strictures.gemspec
  ]

  s.require_path = 'lib'
  s.required_ruby_version = ">= 1.9.3"

  s.author = "Dan Bernier"
  s.email = "danbernier@gmail.com"
  s.homepage = "https://github.com/danbernier/strictures"
end