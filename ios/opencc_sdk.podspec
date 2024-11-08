Pod::Spec.new do |s|
  s.name             = 'opencc_sdk'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter plugin project.'
  s.description      = <<-DESC
A new Flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency "Flutter"
  s.dependency "OpenCC"
  s.xcconfig = {
    "HEADER_SEARCH_PATHS" => "$(PODS_ROOT)/OpenCC/SwiftOpenCC/Sources/OpenCCBridge/include",
    "OTHER_CFLAGS" => "-fembed-bitcode",
  }
  s.ios.deployment_target = "12.0"

  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
