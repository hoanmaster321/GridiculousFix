#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

%hook FBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    NSString *plistPath = [bundlePath stringByAppendingPathComponent:@"Info.plist"];
    NSMutableDictionary *plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];

    if (plistDict) {
        plistDict[@"FBAppVersion"] = @"555";
        [plistDict writeToFile:plistPath atomically:YES];
    }

    return %orig(application, didFinishLaunchingWithOptions:launchOptions);
}

%end
