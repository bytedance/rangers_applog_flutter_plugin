Pod::Spec.new do |s|
  s.name             = 'rangers_applog_flutter_plugin'
  s.version          = '0.0.2'
  s.summary          = 'Official Flutter plugin for RangersAppLog.'
  s.description      = 'Official Flutter plugin for RangersAppLog'
  s.homepage         = 'https://datarangers.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'bytedance' => 'zhuyuanqing@bytedance.com' }
  s.source           = { :path => '.' }
  # s.source           = { :git => 'https://github.com/bytedance/rangers_applog_flutter_plugin.git', :tag =>s.version }

  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  
  s.dependency 'Flutter'
  s.dependency 'RangersAppLog', '5.6.3'

  s.frameworks = 'Foundation'
  s.requires_arc = true
  s.platform = :ios, '9.0'
  s.static_framework = true
  
end

