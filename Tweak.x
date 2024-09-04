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
        // Tìm kiếm một UIWindowScene đang hoạt động
        for (UIScene *scene in [UIApplication sharedApplication].connectedScenes) {
            if ([scene isKindOfClass:[UIWindowScene class]]) {
                UIWindowScene *windowScene = (UIWindowScene *)scene;
                if (windowScene.activationState == UISceneActivationStateForegroundActive) {
                    mainWindow = windowScene.windows.firstObject;
                    break;
                }
            }
        }
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
