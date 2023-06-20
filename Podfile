source 'https://cdn.cocoapods.org/'
source 'git@github.com:mercadolibre/mobile-ios_specs.git'

# This plugin removes input and output files from 'Copy Pods Resources' build phases
# because this issue https://github.com/CocoaPods/CocoaPods/issues/7042
# replaces disable input output paths, its a less invasive workaround
plugin 'cocoapods-clean_build_phases_scripts'
plugin 'cocoapods-whitelist'
plugin 'cocoapods-precompiled'

workspace 'AppIosW2InimigosDessespero'
project 'Example/AppIosW2InimigosDessespero.xcodeproj'

platform :ios, '13.0'
use_frameworks!
inhibit_all_warnings!

target 'AppIosW2InimigosDessespero_Example' do
    pod 'AppIosW2InimigosDessespero', :path => './', inhibit_warnings: false
    # Add this dependency if your module requires authentication, also need to uncomment on AppDelegate MLLogin initialization
    # pod 'MLRegistration'
    pod 'MLConfigurationProvider'

    target 'AppIosW2InimigosDessespero_Tests' do
        inherit! :search_paths
        pod 'Nimble', '~> 9.2.1'
        pod 'Quick', '~> 2.2.0'
    end
end

pre_install do |installer|
	`./scripts/install_git_hooks.sh`
end