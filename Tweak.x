#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SpringBoard : UIApplication
- (void)_simulateLockButtonPress;
@end

%hook SpringBoard

- (void)applicationDidFinishLaunching:(id)application {
    %orig;

    UIWindow *mainWindow = nil;
    if (@available(iOS 15.0, *)) {
        for (UIWindowScene *scene in [UIApplication sharedApplication].connectedScenes) {
            if (scene.activationState == UISceneActivationStateForegroundActive) {
                mainWindow = scene.windows.firstObject;
                break;
            }
        }
    } else if (@available(iOS 13.0, *)) {
        mainWindow = [UIApplication sharedApplication].windows.firstObject;
    } else {
        mainWindow = [UIApplication sharedApplication].keyWindow;
    }
    
    if (mainWindow) {
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        tapRecognizer.numberOfTapsRequired = 2;
        [mainWindow addGestureRecognizer:tapRecognizer];
    }
}

%new
- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    if ([[UIScreen mainScreen] brightness] == 0) {
        [self _simulateLockButtonPress];
    }
}

%end
