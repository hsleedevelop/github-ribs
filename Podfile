install! 'cocoapods', :deterministic_uuids => false
source 'https://github.com/CocoaPods/Specs.git'

# Uncomment this line to define a global platform for your project
platform :ios, '13.0'

# ignore all warnings from all pods
inhibit_all_warnings!

def rx_pods
#   # RX
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxSwiftExt'
end

def architechture_pods
    pod 'RIBs', :git => 'git@github.com:uber/RIBs.git', :branch => 'v0.9.2'
    # pod 'RIBs', '~> 0.9'
end

def debug_pods
  # debug
  pod 'FLEX',   :configurations => ['Debug']
end

def shared_pods
    use_frameworks!
    rx_pods
    architechture_pods
    debug_pods
end

target 'github-ribs' do
    shared_pods
    target 'github-ribsTests' do
        inherit! :search_paths
    end
end


post_install do |installer|
    installer.pods_project.targets.each do |target|
        swift_version = '5.2'
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = swift_version
        end
    end
end
