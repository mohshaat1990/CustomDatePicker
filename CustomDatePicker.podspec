
Pod::Spec.new do |s|
  s.name             = 'CustomDatePicker'
  s.version          = '1.0'
  s.summary          = 'Custom Date Picker'
  s.description      = <<-DESC
Custom Date Picker is swift library to create custom Date picker 
DESC
 
  s.homepage         = 'https://github.com/sh3at90/CustomDatePicker.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '<MOHAMED MAHMOUD>' => '<mohamed.sh3t90@gmail.com>' }
  s.source           = { :git => 'https://github.com/sh3at90/CustomDatePicker.git', :tag => s.version.to_s  }
 
  s.ios.deployment_target = '11.0'
  s.source_files = 'CustomDatePicker/CustomDatePicker/**/*.{lproj,storyboard,xcdatamodeld,xib,swift}'
 
end