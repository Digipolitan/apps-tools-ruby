Gem::Specification.new do |s|
  s.name                  = 'Digipolitan Apps Tools'
  s.version               = 0.0.1
  s.date                  = '2016-12-19'
  s.summary               = 'Digipolitan Ruby tools for apps'
  s.homepage              = 'https://github.com/Digipolitan/apps-tools'
  s.email                 = 'contact@digipolitan.com'
  s.authors               = ['bbriatte', 'vbalasubramaniam']
  s.license               = 'BSD3'
  s.files                 = %w( README.md LICENSE )
  s.files                 += Dir.glob("lib/**/*.rb")
  s.required_ruby_version = '>= 1.9.3'
  s.description           = <<desc
Digipolitan Apps Tools is a Ruby library. This module help you building some iOS / Android app script.
desc
end
