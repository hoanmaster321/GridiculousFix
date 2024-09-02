#import <UIKit/UIKit.h>
#import <SpringBoard/SpringBoard.h>

@interface SBLockScreenViewController : UIViewController
- (BOOL)isVisible;
@end

@interface SBSRelaunchAction : NSObject
+ (instancetype)actionWithReason:(NSString *)reason options:(NSUInteger)options targetURL:(NSURL *)url;
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
        
        // Tạo và thực hiện action để đánh thức thiết bị
        SBSRelaunchAction *wakeUpAction = [%c(SBSRelaunchAction) actionWithReason:@"TouchWake" options:0 targetURL:nil];
        [[%c(SBMainScreenManager) sharedInstance] wakeUpScreenWithCompletion:nil];
    }
}

%end
