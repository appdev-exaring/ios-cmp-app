Pod::Spec.new do |s|
  s.name             = 'ConsentViewController'
  s.version          = '7.3.1'
  s.summary          = 'SourcePoint\'s ConsentViewController to handle privacy consents.'
  s.homepage         = 'https://www.sourcepoint.com'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'SourcePoint' => 'contact@sourcepoint.com' }
  s.source           = { :git => 'https://github.com/SourcePointUSA/ios-cmp-app.git', :tag => s.version.to_s }
  s.swift_version    = '5.0'
  s.source_files = 'ConsentViewController/Classes/**/*'
  s.ios.deployment_target = '14.0'
  s.ios.exclude_files = 'ConsentViewController/Classes/Views/tvOS'
  s.tvos.deployment_target = '14.0'
  s.tvos.exclude_files = 'ConsentViewController/Classes/Views/iOS'
  s.dependency 'Down', '~> 0.11.0' # Linked for both platforms for SPM binary frameworks support
  s.resource_bundles = { 'ConsentViewController' => ['ConsentViewController/Assets/**/*', 'Pod/Classes/**/*.{storyboard,xib,xcassets,json,imageset,png,js}'] }
  s.resources = "ConsentViewController/**/*.{js,json,png}"
  s.info_plist = {
      'SPEnv' => 'prod'
  }
end
