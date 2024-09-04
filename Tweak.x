#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SpringBoard : UIApplication
- (void)_simulateLockButtonPress;
@end

%hook SpringBoard

- (void)applicationDidFinishLaunching:(id)application {
    %orig;
    
    UIWindow *mainWindow;
    if (@available(iOS 13.0, *)) {
        // iOS 13 trở lên, hỗ trợ nhiều scenes
        mainWindow = [UIApplication sharedApplication].windows.firstObject;
    } else {
        // iOS cũ hơn, sử dụng keyWindow
        mainWindow = [UIApplication sharedApplication].keyWindow;
    }
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tapRecognizer.numberOfTapsRequired = 2;
    [mainWindow addGestureRecognizer:tapRecognizer];
}

%new
- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    if ([[UIScreen mainScreen] brightness] == 0) {
        [self _simulateLockButtonPress];
    }
}

%end
