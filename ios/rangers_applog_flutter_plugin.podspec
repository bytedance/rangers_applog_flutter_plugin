Pod::Spec.new do |s|
  s.name             = 'rangers_applog_flutter_plugin'
  s.version          = '0.0.1'
  s.summary          = 'Flutter plugin for RangersAppLog.'
  s.description      = 'Flutter plugin for RangersAppLog'
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'RangersAppLog','~> 3.2.6'
  s.frameworks = 'Foundation'
  s.requires_arc = true
  s.ios.deployment_target = '8.0'
  s.static_framework = true
  
end

