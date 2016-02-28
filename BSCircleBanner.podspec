Pod::Spec.new do |s|
  s.name     = 'BSCircleBanner'
  s.version  = '0.0.1'
  s.summary = 'A circle scroll view for iOS.'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.homepage = 'https://github.com/juxingzhutou/BSCircleBanner.git'
  s.author = { 'juxingzhutou' => 'juxingzhutou@gmail.com' }

  s.platform = :ios
  s.ios.deployment_target = '7.0'
  s.requires_arc = true

  s.source = { :git => "https://github.com/juxingzhutou/BSCircleBanner.git", :tag => 'v0.0.1' }
  s.source_files = "BSCircleBanner/**/*.{h,m}"
  s.public_header_files = "BSCircleBanner/BSCircleBanner.h", "BSCircleBanner/BSSingleBannerCVCell.h"

  s.dependency "Masonry", "~>0.6.2"

end
