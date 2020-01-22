$:.push File.expand_path('lib', __dir__)

require 'zoom_event/version'

Gem::Specification.new do |spec|
  spec.name        = 'zoom_event'
  spec.version     = ZoomEvent::VERSION
  spec.authors     = ['Tom Gladhill', 'Weston Triemstra']
  spec.email       = ['tom@netsign.com', 'weston@netsign.com']
  spec.homepage    = 'https://github.com/whoojemaflip/zoom_event'
  spec.summary     = 'Zoom webhook integration for Rails.'
  spec.description = 'Zoom webhook integration for Rails.'
  spec.license     = 'MIT'

  spec.files         = Dir['{app,config,lib}/**/*', 'LICENSE.md', 'README.md']
  spec.test_files    = Dir['spec/**/*']

  spec.add_dependency 'activesupport', '>= 3.1'

  spec.add_development_dependency 'rails', ['>= 3.1']
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'pry'
end
