
Pod::Spec.new do |spec|

  spec.name         = 'PPBluetoothKit'
  spec.version      = '1.0'
  spec.summary      = 'PPBluetoothKit is a SDK for Bluetooth.'
  spec.description  = <<-DESC   
  PPBluetoothKit is a SDK for Bluetooth.
                       DESC
  spec.homepage     = 'https://www.lefu.cc/'
  spec.source       = { :git => '' }
  spec.author       = 'Peng'
  spec.requires_arc = true
  spec.platform     = :ios, '9.0'

  spec.ios.vendored_frameworks = 'PPBluetoothKit.xcframework'
  spec.resource = 'PPBluetoothKit.bundle'


end
