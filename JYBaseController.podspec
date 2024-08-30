Pod::Spec.new do |spec|
  	spec.name         = "JYBaseController"
  	spec.version      = "1.0.0"
  	spec.summary      = "自用的控制器基类"
  	spec.homepage     = "https://github.com/JYYQLin/JYYQ_BaseController"
  	spec.license      = { :type => "MIT", :file => "LICENSE" }
  	spec.author       = { "JYYQLin" => "No mailBox" }
  	spec.platform     = :ios, "13.0"
  	spec.source       = { :git => "https://github.com/JYYQLin/JYYQ_BaseController.git", :tag => "#{spec.version}" }
  	spec.source_files  = "JYBaseController/*.{h,m,swift}"
	spec.swift_versions = ['5.0', '5.1', '5.2']

	spec.dependency "JYScreen"
	spec.dependency "JYExtension"
	spec.dependency "JY_Localization_Tool"

end
