#import <UIKit/UIKit.h>

%hook SpringBoard

- (void)applicationDidFinishLaunching:(id)application {
    %orig;
    
    // Kích hoạt tính năng Tap to Wake
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleTapToWake:)
                                                 name:@"SBBacklightControllerAutoDimmedNotification"
                                               object:nil];
}

- (void)handleTapToWake:(NSNotification *)notification {
    UIScreen *mainScreen = [UIScreen mainScreen];
    if (mainScreen.brightness == 0) {
        // Set độ sáng màn hình lên giá trị nhỏ nhất có thể (kích hoạt màn hình)
        [mainScreen setBrightness:0.01];
    }
}

%end
