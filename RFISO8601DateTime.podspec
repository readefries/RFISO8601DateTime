#
# Be sure to run `pod lib lint RFISO8601DateTime.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "RFISO8601DateTime"
  s.version          = "3.0.3"
  s.summary          = "A library to easily use ISO8601 date and time."
  s.description      = <<-DESC 
  			A small library that can automatically parse ISO8601/RFC3339/RFC2822 date
  			and time. It extends NSDate and recognise different date and time formats using regular expression.
  					
                       DESC

  s.homepage         = "https://github.com/readefries/RFISO8601DateTime"
  s.license          = 'MIT'
  s.author           = { "Hindrik Bruinsma" => "de@readefries.nl" }
  s.source           = { :git => "https://github.com/readefries/RFISO8601DateTime.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/readefries'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'RFISO8601DateTime/**/*.swift'

end
