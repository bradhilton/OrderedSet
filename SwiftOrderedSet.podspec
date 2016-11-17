Pod::Spec.new do |s|
  s.name         = "SwiftOrderedSet"
  s.version      = "3.0.0"
  s.summary      = "Native Swift Ordered Set"
  s.description  = <<-DESC
                    A native Swift implementation of an ordered set. Supports the same behavior and functionality as native Swift arrays and sets, ensuring that each and every element in an ordered list only appears once.
                   DESC
  s.homepage     = "https://github.com/bradhilton/OrderedSet"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Brad Hilton" => "brad@skyvive.com" }
  s.source       = { :git => "https://github.com/bradhilton/OrderedSet.git", :tag => "3.0.0" }

  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"

  s.source_files  = "Sources", "Sources/**/*.{swift,h,m}"
  s.requires_arc = true
end
