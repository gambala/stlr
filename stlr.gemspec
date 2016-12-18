lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'stlr/version'

Gem::Specification.new do |s|
  s.name     = 'stlr'
  s.version  = Stlr::VERSION
  s.authors  = ['Vitaliy Emeliyantsev']
  s.email    = 'gambala.rus@gmail.com'
  s.summary  = 'stlr is a couple of mixins for sass'
  s.homepage = 'https://github.com/gambala/stlr'
  s.license  = 'MIT'
  s.files    = `git ls-files`.split("\n")
  s.add_runtime_dependency 'sass', '>= 3.3.4'
  s.add_runtime_dependency 'autoprefixer-rails', '>= 5.2.1'
  s.add_development_dependency 'term-ansicolor' # Converter
end
