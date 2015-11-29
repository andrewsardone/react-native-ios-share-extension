# React Native Share Extension Proof of Concept

This is an example project in a tinkering attempt to get an [iOS Share
Extension][ase] UI to include a React Native UI.

[ase]: https://developer.apple.com/library/ios/documentation/General/Conceptual/ExtensibilityPG/ShareSheet.html#//apple_ref/doc/uid/TP40014214-CH12-SW1

## Running the iOS app

```bash
open ios/ShareExtensionExample.xcodeproj
# hit the Run button
```

## Running the app's iOS share extension

1. Select the `ShareExtension` scheme in Xcode
- Tell Xcode to run within Safari
- Click the Share button in the iOS simulator's Safari.app
- Select the `ShareExtension` icon to bring up the share extension UI
