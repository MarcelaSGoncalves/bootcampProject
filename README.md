# app-ios-w2-inimigos-dessespero

## Example

To run the example project, clone the repo, and run `bundle exec pod install` from the Example directory first.

## Requirements

## Installation

app-ios-w2-inimigos-dessespero is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "app-ios-w2-inimigos-dessespero"
```

## Testing UI
For UI Tests we are using Appium and Nativefat Library. To download Nativefat you have to clone the repository:
https://github.com/mercadolibre/fury_nativefat-cli

Once cloned, check necessary dependencies in Readme file and execute the script in the root folder of Nativefat.

```ruby
bash install.sh
```

To create the test scaffolding, you need to execute the script below in the root folder of the mobile library:

nativefat init -e appium
You can add the plataform with the parameters: -p ios / -p android / -p mobile (For both).

For more infos about how to install Nativefat, check the Readme file below:
https://github.com/mercadolibre/fury_nativefat-cli/blob/master/README.md

## Author

ext_feteruel, ext_feteruel@mercadolibre.com

## License

app-ios-w2-inimigos-dessespero is available under the MIT license. See the LICENSE file for more info.
