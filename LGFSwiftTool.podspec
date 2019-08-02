
Pod::Spec.new do |s|

s.name        = "LGFSwiftTool"
s.version     = "0.0.1"
s.summary     = "LGFSwiftTool"
s.homepage    = "https://github.com/aiononhiii/LGFSwiftTool.git"
s.license     = { :type => 'MIT', :file => 'LICENSE' }
s.authors     = { "aiononhiii" => "452354033@qq.com" }

s.requires_arc = true
s.platform     = :ios, "9.0"
s.source   = { :git => "https://github.com/aiononhiii/LGFSwiftTool.git", :tag => s.version }
s.framework  = "Foundation", "UIKit"
s.source_files = 'LGFSwiftTool/**/*.{h,m}'
#s.resource_bundles = {
#  'LGFOCTool' => ['LGFOCTool/**/**/*.{xib,storyboard,png}']
#}

s.user_target_xcconfig = { 'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES' }
end
