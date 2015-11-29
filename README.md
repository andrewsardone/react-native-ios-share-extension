# React Native Share Extension Proof of Concept

This is an example project in a tinkering attempt to get an [iOS Share
Extension][ase] UI to include a React Native UI. The attempt was inspired by
[facebook/react-native#1626 ][tick].

[ase]: https://developer.apple.com/library/ios/documentation/General/Conceptual/ExtensibilityPG/ShareSheet.html#//apple_ref/doc/uid/TP40014214-CH12-SW1
[tick]: https://github.com/facebook/react-native/issues/1626

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

## Current Problems

On creation of our `ShareViewController`'s `RCTRootView`, the
`com.facebook.React.JavaScript` thread [seemingly attempts to execute our app
JavaScript within `RCTContextExecutor`][1], but comes back with a warning log
message:

```
[warn][tid:com.facebook.React.JavaScript][RCTContextExecutor.m:129] 'undefined is not an object (evaluating \'RCTWebSocketModule.connect\')'
```

Ultimately the process crashes (at [this line][2]) with the following log:

```
2015-11-29 12:44:34.726 ShareExtension[66473:2179009] -[RCTBatchedBridge redBox]: unrecognized selector sent to instance 0x7fb59d8ab200
2015-11-29 12:53:47.160 [warn][tid:com.facebook.React.JavaScript][RCTContextExecutor.m:129] 'Requiring module "InitializeJavaScriptAppEngine" which threw an exception'
2015-11-29 12:53:47.160 ShareExtension[66473:2179009] *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '-[RCTBatchedBridge redBox]: unrecognized selector sent to instance 0x7fb59d8ab200'
*** First throw call stack:
(
	0   CoreFoundation                      0x000000010727cf45 __exceptionPreprocess + 165
	1   libobjc.A.dylib                     0x0000000106cf6deb objc_exception_throw + 48
	2   CoreFoundation                      0x000000010728556d -[NSObject(NSObject) doesNotRecognizeSelector:] + 205
	3   CoreFoundation                      0x00000001071d2eea ___forwarding___ + 970
	4   CoreFoundation                      0x00000001071d2a98 _CF_forwarding_prep_0 + 120
	5   ShareExtension                      0x0000000106753e08 ___RCTLogInternal_block_invoke108 + 72
	6   libdispatch.dylib                   0x000000010a4e9d59 _dispatch_call_block_and_release + 12
	7   libdispatch.dylib                   0x000000010a5054a7 _dispatch_client_callout + 8
	8   libdispatch.dylib                   0x000000010a4eff2d _dispatch_main_queue_callback_4CF + 714
	9   CoreFoundation                      0x00000001071dd2e9 __CFRUNLOOP_IS_SERVICING_THE_MAIN_DISPATCH_QUEUE__ + 9
	10  CoreFoundation                      0x000000010719e8a9 __CFRunLoopRun + 2073
	11  CoreFoundation                      0x000000010719de08 CFRunLoopRunSpecific + 488
	12  GraphicsServices                    0x000000010bd3fad2 GSEventRunModal + 161
	13  UIKit                               0x00000001081c730d UIApplicationMain + 171
	14  libxpc.dylib                        0x000000010a7f660b _xpc_objc_main + 467
	15  libxpc.dylib                        0x000000010a7f8982 xpc_main + 189
	16  Foundation                          0x0000000106a7a047 service_connection_handler + 0
	17  PlugInKit                           0x0000000110b78e5f -[PKService run] + 521
	18  PlugInKit                           0x0000000110b78b24 +[PKService main] + 55
	19  PlugInKit                           0x0000000110b78e83 +[PKService _defaultRun:arguments:] + 17
	20  libextension.dylib                  0x000000010982506e NSExtensionMain + 51
	21  libdyld.dylib                       0x000000010a53492d start + 1
)
libc++abi.dylib: terminating with uncaught exception of type NSException
2015-11-29 12:53:48.346 MobileSafari[66468:2191561] plugin org.reactjs.native.example.ShareExtensionExample.ShareExtension interrupted
2015-11-29 12:53:48.347 MobileSafari[66468:2191561] plugin org.reactjs.native.example.ShareExtensionExample.ShareExtension invalidated
2015-11-29 12:53:48.348 MobileSafari[66468:2178614] viewServiceDidTerminateWithError:: Error Domain=_UIViewServiceInterfaceErrorDomain Code=3 "(null)" UserInfo={Message=Service Connection Interrupted}
```

The line `'Requiring module "InitializeJavaScriptAppEngine" which threw an
exception'` looks particularly suspicious.


[1]: https://github.com/facebook/react-native/blob/v0.15.0/React/Executors/RCTContextExecutor.m#L528
[2]: https://github.com/facebook/react-native/blob/v0.15.0/React/Base/RCTLog.m#L239
