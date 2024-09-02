#import <UIKit/UIKit.h>
#import <SpringBoard/SpringBoard.h>

%hook SBLockScreenViewController

// Hook vào sự kiện chạm vào màn hình khóa
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];

    // Kiểm tra xem màn hình có đang khóa không
    if ([self isVisible]) {
        // Bật sáng màn hình khi chạm vào
        SBSRelaunchAction *wakeUpAction = [NSClassFromString(@"SBSRelaunchAction") actionWithReason:@"TouchWake" options:SBSRelaunchActionOptionNone targetURL:nil];
        [[NSClassFromString(@"SBSRelaunchAction") mainScreen] wakeWithCompletion:nil];
    }
}

%end
