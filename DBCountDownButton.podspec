
Pod::Spec.new do |s|

  s.name         = "DBCountDownButton"
  s.version      = "0.0.1"
  s.summary      = "一个简单易用无风险的验证码倒计时控件"

  s.homepage     = "https://github.com/DreamBuddy/DBCountDownButton.git"
 
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author       = { "DreamBuddy" => "304511495@qq.com" }

  s.platform     = :ios, "6.0"

  s.source       = { :git => "https://github.com/DreamBuddy/DBCountDownButton.git", :tag => s.version.to_s }

  s.source_files = "DBCountDownButton/*.{h,m}"

  s.requires_arc = true

  s.dependency 'ReactiveObjC'

end
