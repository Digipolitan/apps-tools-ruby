Gem::Specification.new do |s|
  s.name                  = 'digipolitan-apps-tools'
  s.version               = '0.2.0'
  s.date                  = '2017-02-20'
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
s.add_dependency("colorize")
end
