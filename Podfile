# Uncomment the next line to define a global platform for your project
platform :ios, '15.0'

use_frameworks!
  
  # Pods for WATRWELL
def rx_pods
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxOptional'
  pod "RxAppState"
end

def app_pods
  pod 'NVActivityIndicatorView', '~> 4.8.0'
  pod 'BraintreeDropIn'
end

def maps
  pod 'GoogleMaps'
  pod 'GooglePlaces'
  pod 'Google-Maps-iOS-Utils'

end

def analytics
  pod 'Firebase/Crashlytics'
  pod 'Firebase/Analytics'
end

target 'WATRWELL' do
rx_pods
app_pods
maps
analytics
end
