#import "ShareViewController.h"
#import <RCTRootView.h>

@implementation ShareViewController

- (void)loadView {
    // hardcoding our JS to be served from the dev server while we're
    // experimenting with the share extension setup
    NSURL *jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios&dev=true"];

    // attempt to initialize an RCTRootView and use it as the root view of our
    // plain ‘ol UIViewController
    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                        moduleName:@"ShareExtensionExample"
                                                 initialProperties:nil
                                                     launchOptions:nil];
    self.view = rootView;
}

@end
