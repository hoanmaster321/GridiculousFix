#import <UIKit/UIKit.h>
#import <SpringBoard/SpringBoard.h>

@interface SBLockScreenViewController : UIViewController
- (BOOL)isVisible;
@end

@interface SBBacklightController : NSObject
+ (instancetype)sharedInstance;
- (void)turnOnScreenFullyWithBacklightSource:(NSInteger)source;
@end

%hook SBLockScreenViewController

// Hook vào sự kiện chạm vào màn hình khóa
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    %orig; // Gọi phương thức gốc
    
    // Kiểm tra xem màn hình có đang khóa không
    if ([self isVisible]) {
        // Bật sáng màn hình khi chạm vào
        SBBacklightController *backlightController = [%c(SBBacklightController) sharedInstance];
        [backlightController turnOnScreenFullyWithBacklightSource:1];
        
        // Đánh thức thiết bị
        [[%c(SBLockScreenManager) sharedInstance] unlockUIFromSource:0 withOptions:nil];
    }
}

%end
