Gem::Specification.new do |s|
  s.name = "custom_headers"
  s.version = "0.1.0"
  s.summary = "Rack middleware for easily adding custom headers."
  s.description = "Rack::CustomHeaders is a Rack middleware for adding custom headers either by passing in a generator proc or using the default as UUID."
  s.author = "Tejas Bubane"
  s.email = "tejasbubane@gmail.com"
  s.homepage = "https://github.com/tejasbubane/custom_headers"

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- spec/*`.split("\n")

  s.add_development_dependency "rspec"
  s.add_development_dependency "rack"
  s.add_development_dependency "rake"
  s.add_development_dependency "byebug"
end
