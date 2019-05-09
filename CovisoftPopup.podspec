#
#  Be sure to run `pod spec lint CovisoftPopup.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
          #1.
          s.name               = "CovisftPopup"
          #2.
          s.version            = "1.0.0"
          #3.  
          s.summary         = "Sort description of 'CovisftPopup' framework"
          #4.
          s.homepage        = "http://covisoft.asia"
          #5.
          s.license              = "MIT"
          #6.
          s.author               = "Kai Luu"
          #7.
          s.platform            = :ios, "10.0"
          #8.
          s.source              = { :git => "https://github.com/ios-covi-team/CovisoftPopup.git", :tag => "1.0.0" }
          #9.
          s.source_files     = "CovisftPopup", "CovisftPopup/**/*.{h,m,swift}"
    end