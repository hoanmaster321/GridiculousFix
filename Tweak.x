#import <UIKit/UIKit.h>
#import <SpringBoard/SpringBoard.h>

@interface SBBacklightController : NSObject
- (void)_handleUserTouchOnScreen;
@end

%hook SBBacklightController

- (void)_handleUserTouchOnScreen {
    // Bật màn hình khi chạm vào
    [self _resetLockScreenIdleTimer];
    [self _noteBacklightLevelDidChange];
    %orig;
}

%end
