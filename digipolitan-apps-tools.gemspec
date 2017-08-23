Gem::Specification.new do |s|
  s.name                  = 'digipolitan-apps-tools'
  s.version               = '0.2.3'
  s.date                  = '2017-08-23'
  s.summary               = 'Digipolitan Ruby tools for apps'
  s.homepage              = 'https://github.com/Digipolitan/apps-tools-ruby'
  s.email                 = 'contact@digipolitan.com'
  s.authors               = ['bbriatte', 'vbalasubramaniam']
  s.license               = 'BSD-3-Clause'
  s.files                 = %w( README.md LICENSE CHANGELOG.md )
  s.files                 += Dir.glob("lib/**/*.rb")
  s.required_ruby_version = '>= 1.9.3'
  s.description           = <<desc
Digipolitan Apps Tools is a Ruby library. This module help you building some iOS / Android app script.
desc
s.add_runtime_dependency 'colorize', '~> 0.8.1'
end
