#
# Be sure to run `pod lib lint NRMirror.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'NRMirror'
s.version          = '2.0.0'
s.summary          = 'NRMirror helps you to sync your model with web service response or any input dictionary.So its work like a object mapper for you.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description      = <<-DESC
NRMirror helps you to sync your model with web service response or any input dictionary.So its work like a object mapper for you. So dont worry about your model syncing , just declare your models and name your key same as your dictionary/Json key and you are done. NRMirror supporting of all types Int, String ,Float , Bool etc.. and NRMirror subclass models.
DESC

s.homepage         = 'https://github.com/naveenrana1309/NRMirror'
# s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'naveenrana1309' => 'naveenrana1309@gmail.com' }
s.source           = { :git => 'https://github.com/naveenrana1309/NRMirror.git', :tag => s.version.to_s }
s.social_media_url = 'https://www.linkedin.com/in/naveen-rana-9a371a40'

s.ios.deployment_target = '10.0'

s.source_files = 'NRMirror/Classes/**/*'

# s.resource_bundles = {
#   'NRMirror' => ['NRMirror/Assets/*.png']
# }

# s.public_header_files = 'Pod/Classes/**/*.h'
# s.frameworks = 'UIKit', 'MapKit'
# s.dependency 'AFNetworking', '~> 2.3'
end
